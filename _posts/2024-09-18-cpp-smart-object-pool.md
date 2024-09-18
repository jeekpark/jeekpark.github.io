---
title: "스마트 오브젝트 풀 만들기"
excerpt: "스택기반의 스마트 포인터를 이용한 자동반납 오브젝트 풀"

categories:
  - C++
tags:
  - []

permalink: /categories/cpp/smart-object-pool/

toc: true
toc_sticky: true

date: 2024-09-18
last_modified_at: 2024-09-18
---

# SmartObjectPool

C++의 스마트포인터(unique_ptr)을 이용한 오브젝트풀 ```header-only``` 라이브러리입니다. 해당 라이브러리는 게임, 리얼타임 렌더링, 고성능 프로그래밍에서 메모리 할당과 해제를 줄이기 위해 고정된 수 의 개체를 미리 생성하고, 필요할 때 획득(acquire)하고, 사용후 유니크 포인터를 통해 자동 반납(return, release)하도록 설계되어있습니다. 고정된 크기의 오브젝트풀을 제공하기 때문에 초기화시 필요한 양만큼 미리 생성하고, 이후에는 오브젝트풀의 크기를 조절할 수 없는 정적(static)인 구조입니다.

# 주요 특징
- **static 크기**: 정적 크기 오브젝트풀로 설계되어 있어 메모리 할당을 반복(재할당)하지 않습니다. 오브젝트풀의 크기는 초기화시 지정하고, 이후에는 고정되어있어 사용시 유의가 필요합니다.
- **static 타입**: 오브젝트 풀에 저장할 수 있는 객체의 타입이 컴파일 타임에 고정됩니다. 객체의 타입이 고정되어 있기 때문에, 컴파일 시점에 타입 오류를 쉽게 잡아낼 수 있습니다.
- **noexcept**: 모든 함수(API)는 noexcept로 선언되어있습니다. try-catch, throw, exception 구조는 성능저하를 야기함으로 예외상황은 unique_ptr의 nullptr 반환으로 처리되었습니다. 단 생성자는 반환값이 없기때문에 예외 throw를 발생시킵니다. 생성자가 작동되는 시점은 게임의 로딩씬과 같이 성능저하/부하가 걸려도 무방한 코드에 배치하시기를 권장합니다.
- **자동반납**: unique_ptr의 커스텀 해제(```deleter```)를 통해 객체의 반환을 자동으로 처리합니다. 따라서 ```Acquire()```함수로 객체를 unique_ptr로 획득 한 후, 객체를 사용하고 반납할 때, unique_ptr에서 해제만 해주면 자동으로 반납이 되어 간결한 사용이 가능합니다.
- **스택 기반**: 오브젝트풀은 스택를 통해 획득/반환이 관리 됩니다. 획득과 반환의 성능은 둘다 O(1)로 오브젝트풀을 구현하기 위해서는 스택이 가장 적절한 자료구조입니다.

## 기본사용
```cpp
Pool<Test, 6> pool;
auto obj = pool.Acquire();
if (obj.get() != nullptr)
{
    // 객체 획득 성공
    obj->SomeFunction();
}
else
{
    // 객체 획득 실패
}

```
위 코드에서는 Pool<Test, 6>을 선언하여 크기가 6인 Test 오브젝풀이 생성됩니다. ```Acquire()``` 함수는 객체를 획득(풀에서 하나 꺼내오는)하는 역할을 하며, 만약 풀이 비어있으면 unique_ptr은 nullptr을 가진채로 반환합니다.

## 클래스 가변인자 초기화
```cpp
Pool<Foo, 6> pool{args1, args2}; // Foo의 생성자 인자를 넘김
```
위 코드는 ```Foo```객체를 생성하며 ```Foo```생성자의 인자를 넘겨 오브젝트풀이 객체를 초기화할 수 있도록 합니다.

## 자동 반납
```cpp
class Particle
{
public:
  int x, y;
  Particle(int x, int y) : x(x), y(y) {}
};

int main()
{
  Pool<Particle, 10> particlePool(0, 0); // x, y 좌표 0으로 Particle 객체 10개 생성

  auto particle = particlePool.Acquire();
  particle->x = 10;
  particle->y = 20;

  // particle 객체가 범위를 벗어나면 자동으로 풀에 반환됨
}
```
위 코드는 객체를 반납하는 코드입니다. 

**unique_ptr가 스코프를 벗어나거나(unique_ptr의 RAII 특성 참고)** 명시적으로 ```reset()```이 호출될 때, 커스텀 ```deleter```가 호출되어 자동으로 오브젝트풀에 객체가 반납됩니다.

# 소스코드 설명

## 1. Pool 클래스
```Pool``` 클래스는 정적 크기(```PoolSize```)의 객체를 생성하여 객체의 사용과 반납을 관리합니다. 필요할 때 객체를 풀에서 꺼내오고, 사용 후 다시 풀에 반환되는 방식입니다. **유니크 포인터**의 커스텀 해제자를 통해 메모리 관리를 자동화합니다.

**클래스 정의**

```cpp
template <typename T, size_t PoolSize>
class Pool
```

```Pool```클래스는 두 개의 템플릿 매개변수를 받습니다.
- ```T```: 풀에 저장할 객체의 정적 타입
- ```PoolSize```: 풀에 생성할 객체의 개수(정적)

템플릿 인자를 통해 객체의 타입과 크기를 고정하여 정적인 오브젝트 풀을 정의합니다.

**멤버 변수**

1. ```mAvailableObjects```
```cpp
template<typename T>
class ReservableStack : public std::stack<T, std::vector<T>>
{
public:
  void reserve(size_t n) { this->c.reserve(n); }
};

ReservableStack<T*> mAvailableObjects; // 스택

```
```mAvailableObjects```는 사용 가능한 오브젝트들을 스택으로 저장하여 하나씩 획득할 수 있도록합니다.

여기서 타입이 독특합니다. ```ReservableStack```은 메모리 크기를 미리 확보할 수 있는 ```std::stack```의 변형 스택입니다. ```std::stack```은 기본값으로 내부 컨테이너를 ```std::deque```로 사용합니다. ```std::deque```는 push/pop 과정에서 메모리 재할당이 자동으로 이루어질 수 있는 위험이 있습니다. 게임이나 고성능 프로그래밍에서 의도하지 않은 병목이 발생할 수 있기 때문에 정적인 크기로 지정하여 해당 크기 안에서 push/pop을 하더라도 메모리 재할당이 자동으로 작동하지 않도록 방지해줍니다. ```ReservableStack```은 ``` std::stack<T, std::vector<T>>```을 상속받아 스택의 내부 구조가 ```std::vector```로 작동할 수 있도록 해주고, ```reserve()```함수를 노출하여 스택의 크기를 미리 확보할 수 있도록합니다. 만약 ```reserve(500)```을 호출하여 미리 500개의 공간을 만들어 둔다면 500개 내의 요소를 push/pop하는 과정에서는 메모리 재할당이 일어나지 않습니다.

2. ```mAllPointers```

```cpp
std::vector<T*> mAllPointers; // 벡터 배열
```

```mAllPointers```은 오브젝트 풀이 생성한 모든 객체의 포인터를 저장하는 배열입니다. 오브젝트 풀이 소멸될 때, 생성한 모든 오브젝트를 해제할 의무가 있기 때문에 소멸자에서 해당 배열을 통해 모든 오브젝트를 해제시켜줄 예정입니다.



**생성자**

```cpp
template <typename... Args>
Pool(Args&&... args)
{
  mAvailableObjects.reserve(PoolSize);
  for (size_t i = 0; i < PoolSize; ++i)
  {
    T* obj = new T(args...);
    mAvailableObjects.push(obj);
    mAllPointers.push_back(obj);
  }
}
```
생성자에서는 가변인자 템플릿을 이용해 ```T```객체의 생성자를 호출합니다. 가변인자 템플릿을 이용한다면 디폴트 생성자 외의 다양한 생성자로 객체를 초기화할 수 있는 이점이 있습니다.

풀에 저장할 객체는 ```mAvailableObjects```스택과 ```mAllPointers```배열에 모두 저장됩니다.

동일한 요소를 똑같이 저장하는 두 자료구조입니다. 용도는 다음과 같이 구분됩니다.
- ```mAvailableObjects```: 획득/반환을 위해 저장하는 스택(필요할때 하나씩 pop해서 준다.)
- ```mAllPointers```: ```Pool``` 소멸시 모든 객체를 해제시켜주기 위해 저장.

**소멸자**

```cpp
~Pool()
{
  assert(mAvailableObjects.size() == PoolSize /* Unreleased objects exist */);
  for (auto obj : mAllPointers)
  {
    delete obj;
  }
}
```

소멸자에서는 풀에 남아 있는 객체 수가 생성된 객체 수와 같은지 확인하는 ```assert```를 호출합니다.

해당 ```assert```는 제대로 반환되지 않은 객체가 있을 경우 작동됩니다. 이미  ```mAllPointers```에 모든 객체의 포인터를 저장해두었기 때문에 메모리는 해제 가능하지만, 반환되지 않은 객체를 가지고 있는 다른 곳에서 이미 해제된 객체를 사용할 경우 문제가 발생할 수 있습니다. ```assert```를 통해 디버깅을 용이하도록 해줍니다. (하지만 유니크 포인터의 커스텀 해제자로 자동 반환이 되는 구조이므로 이러한 문제는 쉽게 발생하지 않을 것 같습니다.)

**```Acquire()``` 함수**

```cpp
auto Acquire() noexcept
{
  auto deleter = [this](T* obj)
    {
      if (obj != nullptr)
      {
          this->mAvailableObjects.push(obj);
      }
    };

  if (mAvailableObjects.size() == 0)
  {
      return std::unique_ptr<T, decltype(deleter)>(nullptr, deleter);
  }

  T* obj = mAvailableObjects.top();
  mAvailableObjects.pop();
  return std::unique_ptr<T, decltype(deleter)>(obj, deleter);
}

```

객체를 획득할 수 있는 함수입니다.

반환형은 ```unique_ptr```이지만 ```unique_ptr<T>```형태가 아닌, ```unique_ptr<T, deleter>```형태입니다. 이런 경우에는 ```auto``` 반환을 하는 것이 일반적이고 간편합니다. 함수 호출하여 반환 받는 변수도 ```auto```로 받으면 됩니다.

유니크 포인터 형태로 반환되고, 디폴트 해제자가 아닌 ```커스텀 해제자```로 반환값이 만들어집니다. 디폴트 해제자는 ```unique_ptr<T>```가 소멸될 때, 내부 포인터 ```T*```를 ```delete```하지만 커스텀 해제자를 사용할 경우 내부 포인터 ```T*```를 ```delete```하지 않고 특수한 동작을 지정할 수 있습니다.

해당 코드에서는 ```deleter```라는 람다 함수를 통해 ```커스텀 해제자```를 만들었습니다. 오브젝트풀에서 가져온 객체가 사용이 완료될 경우(```unique_ptr```이므로 스코프를 벗어나거나, ```unique_ptr```의 ```reset()```호출) 해당 해제자가 작동됩니다. 코드 구현을 보면 ```T* obj```를 ```delete```하는 것이 아닌, 오브젝트풀(```this```)의 ```mAvailableObjects```스택에 다시 Push를 해주는 명령을 동작합니다.

이는 ```unique_ptr```을 이용해 자동반환을 구현한 예시입니다.

반환을 따로 하지 않아도 자동으로 반환이 되는 편리한 이점이 있습니다.

만약 사용가능한 객체가 더이상 없다면, ```nullptr```을 담은 ```unique_ptr```이 반환됩니다.

**```GetAvailableObjectCount()``` 함수**

```cpp
size_t GetAvailableObjectCount() const noexcept { return mAvailableObjects.size(); }
```
현재 풀에서 사용 가능한 객체 수를 반환하는 함수입니다. 이는 풀의 상태를 확인할 때 유용합니다.


## 2. 사용법

```cpp
class Particle
{
public:
  int x, y;
  Particle(int x, int y) : x(x), y(y) {}
};

int main()
{
  Pool<Particle, 10> particlePool(0, 0); // x, y 좌표 0으로 Particle 객체 10개 생성

  auto particle = particlePool.Acquire();
  particle->x = 10;
  particle->y = 20;

  // particle 객체가 범위를 벗어나면 자동으로 풀에 반환됨
}
```

## 3. 전체코드

[깃허브 링크](https://github.com/jeekpark/SmartObjectPool/blob/master/SmartObjectPool/jkPool.h)
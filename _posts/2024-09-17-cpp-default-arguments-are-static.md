---
title: "가상함수에 디폴트 인자 사용하면 안되는 이유"
excerpt: "디폴트 인자는 동적바인딩이 안된다"

categories:
  - C++
tags:
  - []

permalink: /categories/cpp/default-arguments-are-static/

toc: true
toc_sticky: true

date: 2024-09-17
last_modified_at: 2024-09-17
---

# 가상함수에 디폴트 인자 사용하면 안되는 이유
```cpp
class Base
{
public:
  virtual void Func(int a = 42);
}
```
위의 코드는 위험하다. 

# 문제의 상황
```cpp
#include <iostream>

class Base 
{
public:
  virtual void printMessage(std::string message = "Base Message")
  {
    std::cout << message << std::endl;
  }
};

class Derived : public Base
{
public:
  void printMessage(std::string message = "Derived Message") override
  {
    std::cout << message << std::endl;
  }
};

int main()
{
  Base* obj = new Derived();
  obj->printMessage(); // 예상한 출력: "Derived Message", 실제 출력: "Base Message"
  return 0;
}

```

위 코드에서는 함수 호출은 virtual에 의해 동적으로 실제 타입의 함수를 호출하지만, 디폴트 인자는 동적으로 바인딩되지 않는다는 것을 알 수 있다.

# 디폴트 인자는 컴파일 타임에 결정된다.
디폴트 인자의 원리는 컴파일러가 코드를 파싱할 때, 함수의 인자가 생략되어있으면 컴파일러가 자동으로 디폴트값을 찾아서 채워넣는 방식으로 작동된다.

가상함수는 런타임에 동적으로 호출되는 반면, 디폴트 인자는 컴파일 타임에 변수 타입만 보고 정적으로 값을 넣어버려 디폴트인자는 동적으로 사용되지 못한다.

# 그럼 UB인가? 표준인가?
처음에 UB(정의되지 않은 작동 = 컴파일러마다 구현이 다를 수 있음)이라고 생각했으나 이는 표준 작동이었다. 가상함수는 런타임에 바인딩되기 때문에 런타임에 성능 저하가 살짝 발생한다. 객체 메모리에 가상함수 테이블이 있는 곳을 가리키는 포인터가 존재하고 그 포인터를 통해 자신의 실제 타입의 함수 포인터가 저장되어있는 테이블을 찾아, 함수를 실행한다. 만약 디폴트 인자를 동적으로 바인딩되도록 하기위해서는 가상함수테이블의 구조가 복잡해질 수도 있고, 가상함수 테이블말고 가상함수인자 테이블이라는 새로운 테이블을 또 만들어져야한다. 성능에 좋지 못한 구조이기 때문에 가상함수는 동적으로 바인딩하더라도 디폴트 인자는 정적으로만 바인딩 하도록 설계된 표준이다.

# 디폴트 인자는 함수 호출의 편의를 위한 것
디폴트 인자는 사용성을 편리하게 해주고, ```선택적```으로 사용할 수 있다. 이는 다형성과 다른 의미로 제공되는 기능이므로 항상 가상함수와 함께 사용할 수 있는 기능이 아닌 것이다. 

# 결론
- 디폴트 인자는 가상함수에서 사용해선 안된다.
- 또한 정적이기 때문에, 어떤 시점이든지 동일한 값으로 사용되는 디폴트 인자만 사용되어야한다. 예를 들어 ```void Func(int a = counter++)```는 사용하면 안된다.
- C++의 편의기능이지만 직관적으로 정말 사용했을 때 편리한 경우에는 사용해도 좋지만 왠만하면 그런 상황은 많이 없다. 오히려 헷갈리게 하는 경우가 많고, 차라리 함수 오버로딩으로 인자가 생략된 오버로드 함수를 추가해서 만드는 편이 코드 리딩에 깔끔하다.


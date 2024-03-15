---
title: "빌더 패턴(Builder Pattern)" 

categories:
  - Design-Pattern
tags:
  - [Unity, CSharp]


toc: true
toc_sticky: true
#목차 생성 여부

published: true
#글 공개 여부

date: 2022-01-26T00:00:00+09:00
lastmod: 2022-06-06T10:27:00+09:00
---

이 글은 C#으로 디자인 패턴 중 하나인 빌더 패턴(Builder Pattern)을 공부하고 정리한 글입니다
{: .notice--warning}

## 📕 빌더 패턴의 장점

- 필요한 데이터만 넣어서 객체를 생성 시켜 줄 수 있다
- 가독성에 좋다
- 유연성을 확보 할 수 있다

<br>
<br>

## 📖 클래스 구현

- 일단 캐릭터를 생성해 줄 <u>빌더 클래스를 만들어주기 위해서</u> **캐릭터 클래스**부터 만들어 준다. `class Character`


### 📜Character.cs

```c#
public class Character : MonoBehaviour
{
    private string _name;
    private int _hp;
    private int _money;

    public Character(string name, int hp, int money)
    {
        _name = name;
        _hp = hp;
        _money = money;
    }
}
```

- 캐릭터 클래스를 만들었으면 **캐릭터 빌더**도 만들어 준다. `class CharacterBuilder`
- 먼저 빌더 클래스를 만들고 필요한 변수들을 정의해둔다.

### 📜CharacterBuilder.cs

```c#
public class CharacterBuilder
{
    private const string DefaultName = "Player";
    private const int DefaultHP = 20;
    private const int DefaultMoney = 100;

    private string _name;
    private int _hp;
    private int _money;
}
```

- **기본값이 되는 상수**와 객체에 입력시킬 데이터를 가지고 있는 변수를 정의한다. `const`
- 여기서 기본값이 되는 상수를 정의해주는 이유는 <u>객체를 생성 시킬 때 아무런 값도 설정 안 해줘도 생성되게 하기 위해서</u>이다.

<br>

- 그다음 **생성자**를 정의해 `CharacterBuilder()`

```cpp
public CharacterBuilder()
{
    _name = DefaultName;
    _hp = DefaultHP;
    _money = DefaultMoney;
}
```

- 각 변수에 기본 값을 넣어주도록 하자.

<br>

- 그다음에 변수들을 **변경 시켜 줄 수 있는 함수**를 정의해준다.

```cpp
public CharacterBuilder SetName(string name)
{
    _name = name;
    return this;
}

public CharacterBuilder SetHP(int hp)
{
    _hp = hp;
    return this;
}

public CharacterBuilder SetMoney(int money)
{
    _money = money;
    return this;
}
```

- 여기서 왜 <u>자기 자신을 반환해주지?</u> 라는 의문이 생길 수 있다.
- 함수에서 자기 자신을 반환해 주는 이유는

```cpp
CharacterBuilder builder = new CharacterBuilder();
builder.SetName("코딩덕후").SetHP(100).SetMoney(10000);
```

- 위와 같이 사용하려고 하기 때문이다.

- 마지막으로 객체를 생성시켜주는 **Build 함수**를 정의해준다

```cpp
public Character Build()
{
    Character character = new Character(_name, _hp, _money);
    return character;
}
```

- 여기서 보면 **Build 함수**를 호출하지 않으면 <u>객체를 생성할 수 없다</u>는 걸 알 수 있다.

<br>
<br>

## 📖 순서도

1. 빌더 객체 **생성**
2. 빌더 객체에 **데이터 입력**
3. 빌더 객체의 Build 함수로 **객체 생성**

<br>
<br>

## 📚 사용 예시

```cpp
CharacterBuilder builder = new CharacterBuilder();

Character character = builder.SetName("코딩덕후").SetHP(100).SetMoney(10000).Build();
```

- 위와 같이 사용하거나 또는

```cpp
CharacterBuilder builder = new CharacterBuilder();

Character character = builder.SetName("코딩덕후").Build();
```

- 이름만 설정시켜도 <u>생성자에서 변수들을 기본값으로 초기화시켜뒀으니</u> **정상 작동**한다.


***
<br>

    💻 열심히 공부해서 작성 중이니 오류나 틀린 부분이 있을 경우 
       언제든지 댓글 혹은 메일로 알려주시면 감사하겠습니다! 😸

[맨 위로 이동하기](#){: .btn .btn--primary }{: .align-right}
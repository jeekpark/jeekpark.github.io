---
title: "[Effective C#] 아이템 18: 반드시 필요한 제약 조건만 설정하라"

categories:
  - Effective-CSharp
tags:
  - [CSharp, Book Summary]


toc: false                         # 목차
toc_sticky: false                  # 목차 사이드바 고정

published: false                   #글 공개 여부

date:       2023-08-11T00:00:00+09:00
lastmod:    2023-08-11T00:00:00+09:00
---

<!-- description : 25자에서 160자 사이 -->
**Effective C#의 아이템 18: 반드시 필요한 제약 조건만 설정하라**를 공부하고 정리한 글입니다.<br>
참고 책 : Effective C#
{: .notice--warning}

## 반드시 필요한 제약 조건만 설정하라

- 타입 매개변수에 대한 제약 조건은 작업을 올바르게 수행하기 위해서 타입 매개변수로 전달할 수 있는 타입의 유형을 제한하는 방법
- 개발자는 올바르게 작업을 수행하기 위한 최소하느이 제약 조건만을 설정해야 한다
  - 너무 많은 제약 조건을 설정하면 이를 만족시키기 위해서 사용자들이 과도한 추가 작업을 수행해야 할 수 있다
- 제약 조건을 설정하지 않으면 런타임에 더 많은 검사를 수행할 수밖에 없다
  - 더 자주 형변환, 리플렉션, 잘못된 타입으로 인해 런타임 오류가 발생할 가능성이 높다
- 제약 조건을 설정하면 컴파일러는 System.Object에 정의된 public 메서드보다 더 많은 것을 타입 매개변수에 기대할 수 있게 된다
- 제약 조건은 제네릭 타입에 대해 우리가 가정하고 있는 사실을 컴파일러와 다른 개발자에게 알려주는 용도로 사용된다
- 컴파일러 입장에서는 두 가지 측면에서 도움이 된다
  1. 제네릭 타입을 작성할 때 도움이 된다
  2. 컴파일러가 제네릭 타입을 사용하는 사용자가 타입 매개변수로 올바른 타입을 지정했는지를 컴파일타임에 확인할 수 있다

```c#
public static bool AreEqual<T>(T left, T right)
{
    if (left == null)
        return right == null;
    
    if (left is IComparable<T>)
    {
        IComparable<T> lval = left as IComparable<T>;
        if (right is IComparable<T>)
            return lval.CompareTo(right) == 0;
        else
            throw new Exception();
    }
    else
    {
        throw new Exception();
    }
}

// 제약 조건을 설정하면 간단히 코드를 작성할 수 있다
public static bool AreEqual2<T>(T left, T right) where T : IComparable<T>
{
    return left.CompareTo(right) == 0;
}
```

- 타입 매개변수에 제약 조건을 많이 설정하면 제네릭 타입을 사용하는 것이 큰 부담이 된다
- 타입 매개변수로 지정된 타입이 설사 인스턴스화되었을 때 더 나은 메서드를 가졌다 하더라도 제네릭 타입을 컴파일할 때 알려진 내용이 아니라면 사용하지 않는다

```c#
public class Test : IEquatable<Test>
{
    bool IEquatable<Test>.Equals(Test other) => true;
}

public static bool AreEqual<T>(T left, T right) => left.Equals(right);
public static bool AreEqual2<T>(T left, T right) where T : IEquatable<T> => left.Equals(right);

static void Main()
{
    Test a = new Test();
    Test b = new Test();

    Console.WriteLine(AreEqual(a, b));      // false
    Console.WriteLine(AreEqual2(a, b));     // true
}
```

- IEquatable&lt;T&gt;를 제약 사항으로 설정하면 System.Object.Equals()를 재정의한 메서드가 존재하는지를 런타임에 확인할 필요가 없기 때문에 가상 함수 호출 시 필요한 약간의 오버헤드조차 피할 수 있다
- default() 연산자를 사용할 때 주의해야 한다
  - new()와 default()는 참조타입일 경우 서로 다른 의미를 가진다
- 제네릭 타입을 만드는 이유가 다양한 시나리오에서 적용할 수 있는 범용 타입을 정의하기 위한 것임을 잊지 말자
- 타입 매개변수로 지정할 타입의 유형에 대하여 명확한 가정이 필요하다면 반드시 제약 조건으로 설정하라

***
<br>

    💻 열심히 공부해서 작성 중이니 오류나 틀린 부분이 있을 경우 
      언제든지 댓글 혹은 메일로 알려주시면 감사하겠습니다! 😸


[맨 위로 이동하기](#){: .btn .btn--primary }{: .align-right}
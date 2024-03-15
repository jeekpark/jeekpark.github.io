---
title: "[Effective C#] 아이템 29: 컬렉션을 반환하기보다 이터레이터를 반환하는 것이 낫다"

categories:
  - Effective-CSharp
tags:
  - [CSharp, Book Summary]


toc: false                         # 목차
toc_sticky: false                  # 목차 사이드바 고정

published: false                   #글 공개 여부

date:       2023-08-28T00:00:00+09:00
lastmod:    2023-08-28T00:00:00+09:00
---

<!-- description : 25자에서 160자 사이 -->
**Effective C#의 아이템 29: 컬렉션을 반환하기보다 이터레이터를 반환하는 것이 낫다**를 공부하고 정리한 글입니다.<br>
참고 책 : Effective C#
{: .notice--warning}

## 컬렉션을 반환하기보다 이터레이터를 반환하는 것이 낫다

- 시퀀스를 반환하는 메서드를 작성해야 한다면 컬렉션을 반환하기보다는 이터레이터를 반환하는 것이 좋다
- 이터레이터 메서드란 호출자가 요청한 시퀀스를 생성하기 위해서 yield return문을 사용하는 메서드를 말한다
- 이터레이터 메서드가 호출되면 **시퀀스를 만들어내는 객체를 생성**한다
- 이터레이터를 사용하는 방식이 정확히 필요한 개수의 숫자만을 생성하는 것만큼 효율적이지는 않겠지만 모든 경우의 데이터를 저장하는 것보다는 낫다
- **'필요할 때 생성'**이라는 전략은 이터레이터 메서드를 작성할 때 가장 중요한 전략 중 하나이다
- 이터레이터를 사용할 때 주의해야 할 점은 첫 번째 요소가 요청될 때까지는 내부 로직이 실행되지 않는다는 점이다
  - 이런 경우에는 아래와 같은 코드와 같이 분리해서 작성해 해결할 수 있다

```c#
public static IEnumerable<char> EnumerableChar(bool isError)
{
    if (isError)
        throw new Exception();

    return EnumerableCharImpl();
}

private static IEnumerable<char> EnumerableCharImpl()
{
    yield return 'A';
}
```

- 우리가 작성한 API들을 **사용자들이 어떻게 사용할지 예측할 수 없으므로** API를 좀 더 쉽게 사용할 수 있도록 배려하는 것에 집중하는 편이 좋다
  - 상황에 따라 이터레이터 메서드를 사용하는 방식이 바뀔 수 있기 때문에
    - ex) 필요할 때마다 하나씩 항목을 생성할 수 있고, ToList()나 ToArray()를 이용하여 전체 시퀀스가 저장된 컬렉션을 생성할 수도 있다

***
<br>

    💻 열심히 공부해서 작성 중이니 오류나 틀린 부분이 있을 경우 
      언제든지 댓글 혹은 메일로 알려주시면 감사하겠습니다! 😸


[맨 위로 이동하기](#){: .btn .btn--primary }{: .align-right}
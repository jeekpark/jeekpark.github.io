---
title: "[Effective C#] 아이템 20: IComparable&lt;T&gt;와 ICompararer&lt;T&gt;를 이용하여 객체의 선후 관계를 정의하라"

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
**Effective C#의 아이템 20: IComparable&lt;T&gt;와 ICompararer&lt;T&gt;를 이용하여 객체의 선후 관계를 정의하라**를 공부하고 정리한 글입니다.<br>
참고 책 : Effective C#
{: .notice--warning}

## IComparable&lt;T&gt;와 ICompararer&lt;T&gt;를 이용하여 객체의 선후 관계를 정의하라

- 컬렉션을 정렬하거나 검색하려면 타입 내에 객체의 선후 관계를 판단할 수 있는 기능을 정의해야 한다
- 객체의 선후 관계를 정의하기 위해서 IComparable&lt;T&gt;와 ICompararer&lt;T&gt; 2개의 인터페이스를 제공한다.
- IComparable&lt;T&gt;는 타입의 기본적인 선후 관계를 정의한다
- ICompararer&lt;T&gt;를 이용하면 기본적인 선후 관계 이외에 추가적인 선후 관계를 정의할 수 있다
- IComparable 인터페이스&lt;T&gt;를 구현할 때는 IComparable도 함께 구현해야 한다
  - 오래된 API들은 여전히 IComparable을 사용하기 때문에
- IComparable은 타입 매개변수를 취하지 않기 때문에 올바르지 않은 객체를 전달하는 경우에 대해 아무런 방비가 없다
  - 또한 실제 비교를 위해서는 박싱/언박싱이 필요하므로 성능 비용이 발생한다
- .NET Framework에 제네릭 기능을 포함한 이후 개발된 대부분의 API는 정렬이 필요한 경우 Comparison&lt;T&gt;라는 델리게이트에 작업을 위임하도록 작성됐다
- IComparable과 ICompararer는 타입에 선후 관계를 제공하기 위한 표준 메커니즘이다
- 기본적인 선후 관계는 IComparable을 통해 구현해야 한다
- IComparable 구현할 때에는 관계 연산자도 함께 오버로딩하여 일관된 결과를 제공해야 한다
- 별도로 ICompararer를 이용하면 추가적인 선후 관계를 정의할 수 있을 뿐만 아니라 우리가 직접 개발하지 않은 타입에 대해서도 임의의 선후 관계를 추가로 정의할 수 있다

***
<br>

    💻 열심히 공부해서 작성 중이니 오류나 틀린 부분이 있을 경우 
      언제든지 댓글 혹은 메일로 알려주시면 감사하겠습니다! 😸


[맨 위로 이동하기](#){: .btn .btn--primary }{: .align-right}
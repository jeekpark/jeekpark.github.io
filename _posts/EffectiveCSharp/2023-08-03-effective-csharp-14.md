---
title: "[Effective C#] 아이템 14: 초기화 코드가 중복되는 것을 최소화하라"

categories:
  - Effective-CSharp
tags:
  - [CSharp, Book Summary]


toc: false                         # 목차
toc_sticky: false                  # 목차 사이드바 고정

published: false                   #글 공개 여부

date:       2023-08-03T00:00:00+09:00
lastmod:    2023-08-03T00:00:00+09:00
---

<!-- description : 25자에서 160자 사이 -->
**Effective C#의 아이템 14: 초기화 코드가 중복되는 것을 최소화하라**를 공부하고 정리한 글입니다.<br>
참고 책 : Effective C#
{: .notice--warning}

## 초기화 코드가 중복되는 것을 최소화하라

- 초기화를 할 때 private 헬퍼 메서드를 작성하기 보다는 공용으로 사용할 수 있는 생성자를 작성하는 편이 낫다
- private 헬퍼 메서드에서는 readonly 변수를 초기화 하지 못한다
- 매개변수의 기본값은 컴파일타임 상수만 사용할 수 있다

```c#
public class MyClass
{
    public MyClass(int a, int b)
    {

    }

    public MyClass(int a, int b, string str) : this(a, b)
    {

    }
}
```

***
<br>

    💻 열심히 공부해서 작성 중이니 오류나 틀린 부분이 있을 경우 
      언제든지 댓글 혹은 메일로 알려주시면 감사하겠습니다! 😸


[맨 위로 이동하기](#){: .btn .btn--primary }{: .align-right}
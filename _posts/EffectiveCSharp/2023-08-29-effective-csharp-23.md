---
title: "[Effective C#] 아이템 30: 루프보다 쿼리 구문이 낫다"

categories:
  - Effective-CSharp
tags:
  - [CSharp, Book Summary]


toc: false                         # 목차
toc_sticky: false                  # 목차 사이드바 고정

published: false                   #글 공개 여부

date:       2023-08-29T00:00:00+09:00
lastmod:    2023-08-29T00:00:00+09:00
---

<!-- description : 25자에서 160자 사이 -->
**Effective C#의 아이템 30: 루프보다 쿼리 구문이 낫다**를 공부하고 정리한 글입니다.<br>
참고 책 : Effective C#
{: .notice--warning}

## 루프보다 쿼리 구문이 낫다

- 쿼리 구문을 사용하는 것이 반복문을 사용하는 것보다 더 나은 경우가 꽤 있다

```c#
// 반복 구문
private static IEnumerable<Tuple<int, int>> ProduceIndice()
{
    var storage = new List<Tuple<int, int>>();

    for (var x = 0; x < 100; ++x>)
        for (var y = 0; y < 100; ++y>)
            if (x + y < 100)
                storage.Add(Tuple.Create(x, y));

    storage.Sort((point1, point2)) =>
        (point2.Item1 * point2.Item1 + point2.Item2 * point2.Item2).CompareTo(
            point1.Item1 * point1.Item1 + point1.Item2 + point1.Item2));
    return storage;
}

// 쿼리 구문
private static IEnumerable<Tuple<int, int>> QueryIndice()
{
    return from x in Enumerable.Range(0, 100)
            from y in Enumerable.Range(0, 100)
            where x + y < 100
            orderby (x * x + y * y) descending
            select Tuple.Create(x, y);
}
```

- 쿼리 구문의 장점은 반복 구문보다 **코드의 가독성이 높아진다**
- 또한 **더욱 다양하게 조합이 가능**하다는 점도 장점이다
- 통상 로프를 이용하여 직접 코딩하면 쿼리보다 성능이 좋은 코드를 작성할 수 있지만 **항상 그런 것은 아니다**
- 쿼리 구문을 사용하는 것이 거의 대부분의 경우에 반복 구문을 사용하는 것보다 더욱 깔끔하게 코드를 작성할 수 있을 것이다

***
<br>

    💻 열심히 공부해서 작성 중이니 오류나 틀린 부분이 있을 경우 
      언제든지 댓글 혹은 메일로 알려주시면 감사하겠습니다! 😸


[맨 위로 이동하기](#){: .btn .btn--primary }{: .align-right}
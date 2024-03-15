---
title: "[Effective C#] 아이템 37: 쿼리를 사용할 때는 즉시 평가보다 지연 평가가 낫다"

categories:
  - Effective-CSharp
tags:
  - [CSharp, Book Summary]


toc: false                         # 목차
toc_sticky: false                  # 목차 사이드바 고정

published: false                   #글 공개 여부

date:       2023-09-14T00:00:00+09:00
lastmod:    2023-09-14T00:00:00+09:00
---

<!-- description : 25자에서 160자 사이 -->
**Effective C#의 아이템 37: 쿼리를 사용할 때는 즉시 평가보다 지연 평가가 낫다**를 공부하고 정리한 글입니다.<br>
참고 책 : Effective C#
{: .notice--warning}

## 쿼리를 사용할 때는 즉시 평가보다 지연 평가가 낫다

- 쿼리를 정의한다고해서 결과 데이터나 시퀀스를 즉각적으로 얻어오는 것은 아니다
- 쿼리를 사용해 순회를 수행해야만 결과가 생성된다 (지연평가)
- 쿼리를 작성할 때는 쿼리의 결과를 여러 번 순회하는 경우 어떻게 동작하기를 바라는지를 미리 고려해야 하며, 즉시 데이터의 스냅샷을 얻기 원하는지, 아니면 결과 시퀀스를 생성하는 방법만을 기술할지를 결정해야 한다

```c#
static IEnumerable<int> AllNumbers()
{
    int number = 0;
    while (number < int.MaxValue)
        yield return number++;
}

static void Main(string[] args)
{
    // 1. 순차적으로 0, 1, 2, 3, 4를 출력한다 
    {
        var answers = from number in AllNumbers() select number;
        var smallNumbers = answers.Take(5);
        foreach (var num in smallNumbers)
            Console.WriteLine(num);
    }
    
    // 2. 무한 시퀀스를 생성하므로 프로그램이 멈추거나 오버플로가 발생
    {
        var answers = from number in AllNumbers() where number < 5 select number;
        foreach (var num in answers)
            Console.WriteLine(num);
    }
}
```

- 정상적으로 쿼리를 수행하기 위해서 전체 시퀀스가 필요한 연산자와 함수가 여럿 있다
  - where 이나 Max(), Min() 들이 그 예시이다
- 전체 시퀀스가 필요한 메서드를 사용할 때는 반드시 염두에 두어야 할 사항이 몇가지 있다
  - 시퀀스가 무한정 지속될 가능성이 있다면 이 같은 메서드를 사용할 수 없다
  - 시퀀스가 무한이 아니더라도 시퀀스를 필터링하는 쿼리 메서드는 다른 쿼리보다 먼저 수행하는 것이 좋다
    - <u>선행 단계에서 컬렉션의 요소를 필터링하여 그 개수를 줄일 수 있다면</u> 수행할 쿼리의 성능을 개선할 수 있기 때문이다

```c#
static IEnumerable<int> AllNumbers()
{
    int number = 0;
    while (number < int.MaxValue)
        yield return number++;
}

static void Main(string[] args)
{
    var sortedProductsSlow = 
        from p in products
        orderby p.UnitsInStock descending
        where p.UnitsInStock > 100
        select p;

    // 아래 코드는 이미 정렬할 요소를 줄인 상태에서 정렬하기 때문에 위 코드보다 빠르게 수행된다
    var sortedProductsFast = 
        from p in products
        where p.UnitsInStock > 100
        orderby p.UnitsInStock descending
        select p;
}
```

- 특정 시점에 값을 반드시 알아야 하는 경우는 ToList()와 ToArray() 2개의 메서드를 사용하여 시퀀스로부터 값을 **즉각적으로 평가**하면 된다

***
<br>

    💻 열심히 공부해서 작성 중이니 오류나 틀린 부분이 있을 경우 
      언제든지 댓글 혹은 메일로 알려주시면 감사하겠습니다! 😸


[맨 위로 이동하기](#){: .btn .btn--primary }{: .align-right}
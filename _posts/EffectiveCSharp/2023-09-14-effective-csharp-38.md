---
title: "[Effective C#] 아이템 38: 메서드보다 람다 표현식이 낫다"

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
**Effective C#의 아이템 38: 메서드보다 람다 표현식이 낫다**를 공부하고 정리한 글입니다.<br>
참고 책 : Effective C#
{: .notice--warning}

## 메서드보다 람다 표현식이 낫다

```c#
var allEmployees = FindAllEmployees();

{
    // 20년 이상 근속자
    var earlyFolks = from e in allEmployees
            where e.Classification == EmployeeType.Salary
            where e.YearsOfService >= 20
            where e.MonthlySalary < 4000
            select e;

    // 20년 미만 근속자
    var earlyFolks = from e in allEmployees
            where e.Classification == EmployeeType.Salary
            where e.YearsOfService < 20
            where e.MonthlySalary < 4000
            select e;
}


{
    private static bool LowPaidSalaried(Employee e) => e.MonthlySalary < 4000 && e.Classification == EmployeeType.Salary;

    // 20년 이상 근속자
    var earlyFolks = from e in allEmployees
            where LowPaidSalaried(e) && e.YearsOfService >= 20
            select e;

    // 20년 미만 근속자
    var earlyFolks = from e in allEmployees
            where LowPaidSalaried(e) && e.YearsOfService < 20
            select e;
}
```

- 통상 쿼리 표현식 내의 람다 표현식은 델리케이트로 변환되어 수행된다 (LINQ to Object)
- 다른 경우에는 람다 표현식을 활용하여 표현식 트리를 만들고, 향후 이를 파싱하여 완전히 다른 구문을 생성한 후, 그 결과를 다른 환경에서 수행하기도 한다 (LINQ to SQL)
- LINQ to SQL은 표현식 트리를 활용한다
  - LINQ to SQL 엔진이 표현식 트리를 분석하여 모든 연산을 동일한 작업을 수행하는 T-SQL 구문으로 변경하는데 쿼리 구문 내에 메서드를 호출하는 부분은 T-SQL 표현식으로 변경하지 못한다
  - 이 경우 LINQ to SQL 엔진은 예외를 발생시킨다 (여러 번에 걸쳐 쿼리를 실행한 후 필요한 데이터를 클라이언트 측에서 가져오지 않음)
- 다양한 데이터 소스에 대하여 재사용 가능한 라이브러리를 만드는 경우라면 이러한 상황은 반드시 고려돼야 한다
  - 다양한 데이터 소스를 지정하더라도 올바르게 동작하도록 코드를 작성해야 한다면 람다 표현식을 각각 구분하여 작성하되 인라인으로 해석될 수 있도록 놔둬야 한다

```c#
private static IQueryable<Employee> LowPaidSalariedFilter(this IQueryable<Employee> sequence)
        => from s in sequence
        where s.Classification == EmployeeType.Salary &&
        s.MonthlySalary < 4000
        select s;

// 나머지 부분
var allEmployees = FindAllEmployees();

// 우선 필터링을 수행함
var salaried = allEmployees.LowPaidSalariedFilter();

// 20년 이상 근속자
var earlyFolks = salaried.Where(e => e.YearsOfService >= 20);

// 20년 미만 근속자
var newest = salaried.Where(e => e.YearsOfService < 20);
```

- IQueryable을 사용하는 enumerator를 조합하여 사용할 수 있다
  - 여러 단계에 걸쳐 쿼리를 수행하더라도 결과적으로 원격지에서 쿼리를 수행돼야 할 시점에 단일의 표현식 트리로 결합된다
- 복잡한 쿼리에서 람다 표현식을재사용하는 가장 효율적인 방법 중 하나는 닫힌 제네릭 타입에 대하여 쿼리를 위한 확장 메서드를 작성하는 것이다

***
<br>

    💻 열심히 공부해서 작성 중이니 오류나 틀린 부분이 있을 경우 
      언제든지 댓글 혹은 메일로 알려주시면 감사하겠습니다! 😸


[맨 위로 이동하기](#){: .btn .btn--primary }{: .align-right}
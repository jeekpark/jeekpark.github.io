---
title: "[Effective C#] 아이템 39: funciton과 action 내에서는 예외가 발생하지 않도록 하라"

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
**Effective C#의 아이템 39: funciton과 action 내에서는 예외가 발생하지 않도록 하라**를 공부하고 정리한 글입니다.<br>
참고 책 : Effective C#
{: .notice--warning}

## funciton과 action 내에서는 예외가 발생하지 않도록 하라

- 일련의 값을 순차적으로 처리하는 코드가 중간 어디쯤에서 예외를 일으키면 복구할 수 없는 문제에 봉착한다

```c#
// 예외가 발생
var allEmployees = FindAllEmployees();
allEmployees.ForEach(e => e.MonthlySalary *= 1.05);

// 이미 퇴사한 직원의 정보로 인해 예외가 난 경우 필터링
allEmployees.FindAll(
    e => e.Classification == EmployeeType.Active).
    ForEach(e => e.MonthlySalary *= 1.05);

// 복사본을 만들고 복사본에 대한 수정이 완료되면 원본 시퀀스를 대체하는 방식
var updates = (from e in allEmployees
        select new Employee
        {
            EmployeeId = e.EmployeeId,
            Classification = e.Classification,
            YearsOfService = e.YearsOfService,
            MonthlySalary = e.MonthlySalary *= 1.05
        }).ToList();
allEmployees = updates;
```

- 복사본을 만드는 경우 관리해야 하는 코드의 양이 늘었을 뿐만 아니라 코드를 이해하기도 더 어려워졌다
  - 응용프로그램의 성능에도 영향을 미친다
  - 특히 원본 시퀀스의 크기가 크다면 상당한 성능 저하가 발생할 것이다
- 쿼리 합성은 예외를 다루는 코드 작성 방법에 큰 영향을 미친다
  - action이나 function이 예외를 일으키는 경우 데이터의 비일관성 문제를 피하기 어렵다
  - 하지만 기존의 데이터를 수정하는 대신 새로운 데이터를 생성하도록 코드를 작성하면 <u>작업이 완전히 완료됐는지를 확인할 수 있는 기회가 생길 뿐 아니라 문제가 생겼을 경우 프로그램의 상태를 변경하지 않을 수도 있다</u>
- 위 내용은 멀티스레드 환경에서도 적용해볼 수 있는 내용이다

***
<br>

    💻 열심히 공부해서 작성 중이니 오류나 틀린 부분이 있을 경우 
      언제든지 댓글 혹은 메일로 알려주시면 감사하겠습니다! 😸


[맨 위로 이동하기](#){: .btn .btn--primary }{: .align-right}
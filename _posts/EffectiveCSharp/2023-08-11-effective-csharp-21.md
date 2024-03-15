---
title: "[Effective C#] 아이템 21: 타입 매개변수가 IDisposable을 구현한 경우를 대비하여 제네릭 클래스를 작성하라"

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
**Effective C#의 아이템 21: 타입 매개변수가 IDisposable을 구현한 경우를 대비하여 제네릭 클래스를 작성하라**를 공부하고 정리한 글입니다.<br>
참고 책 : Effective C#
{: .notice--warning}

## 타입 매개변수가 IDisposable을 구현한 경우를 대비하여 제네릭 클래스를 작성하라

- 제약 조건은 타입 매개변수가 무엇을 해야 하는지만을 규정할 수 있고, 무엇을 해서는 안 되는지를 정의할 수 없다
- 타입 매개변수로 지정하는 타입이 IDisposable을 구현하고 있다면 특별한 추가 작업이 반드시 필요하다

```c#
public interface IEngine
{
    void DoWork();
}

public class EngineDriverOne<T> where T : IEngine, new()
{
    public void GetThinsDone()
    {
        T driver = new T();
        using (driver as IDisposable)
        {
            driver.DoWork();
        }
    }
}

public class EngineDriverTwo<T> : IDisposable where T : IEngine, new()
{

    private Lazy<T> driver = new Lazy<T>(() => new T());

    public void GetThingsDone() => driver.Value.DoWork();

    public void Dispose()
    {
        if (driver.IsValueCreated)
        {
            var resource = driver.Value as IDisposable;
            resource?.Dispose();
        }
    }
}
```

- 제네릭 클래스의 타입 매개변수로 객체를 생성하는 경우 이 타입이 IDisposable을 구현하고 있는지를 확인해야 한다
- 항상 방어적으로 코드를 작성하고 객체가 삭제될 때 리소스가 누수되지 않도록 주의해야 한다

***
<br>

    💻 열심히 공부해서 작성 중이니 오류나 틀린 부분이 있을 경우 
      언제든지 댓글 혹은 메일로 알려주시면 감사하겠습니다! 😸


[맨 위로 이동하기](#){: .btn .btn--primary }{: .align-right}
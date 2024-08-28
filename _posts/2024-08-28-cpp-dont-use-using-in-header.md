---
title: "헤더파일에 using 문은 위험하다"
excerpt: "왜 위험할까?"

categories:
  - C++
tags:
  - []

permalink: /categories/cpp/dont-use-using-in-header/

toc: true
toc_sticky: true

date: 2024-08-28
last_modified_at: 2024-08-28
---

# 헤더 파일에 using 문을 사용하는 것은 위험하다.

왜냐하면 그 헤더 파일을 include하는 모든 파일에서 using 문으로 지정한 것이 적용되어버리고, using으로 지정된 방식으로 호출해야하기 때문이다. 네임스페이스나 클래스 스코프 내에서 적용하는 것이 바람직하다.
---
title: "[IoT] 커뮤트 큐브: 2편 아두이노 세팅 (Wemos D1 R32 ESP32)"
excerpt: "인도 형님들은 대단합니다"

categories:
  - Project
tags:
  - []

permalink: /categories/project/commute-cube-2/

toc: true
toc_sticky: true

date: 2024-05-03
last_modified_at: 2024-05-03
---

# 택배가 왔다
아두이노랑 디스플레이를 구매했는데 디스플레이는 재고가 없어서 아두이노를 먼저 받았습니다. 아두이노 우노 베이스 + ESP32 혼합 컨트롤러는 처음 만져봅니다.

<img src="https://raw.githubusercontent.com/jeekpark/jeekpark.github.io/main/assets/images/posts_img/commute-cube/arduino-wemos.jpg">

두근두근

국내 배송으로 6-7000원 가량에 구매했는데 알리에서 3000원에 팔리고 있습니다. 가성비가 좋습니다. 

핀맵이 다르거나 기존 우노 쉴드를 그대로 사용하지 못할 가능성이 있으니, 천천히 살펴볼려고 합니다.

# 오랜만에 다시 만난 아두이노 IDE
<img src="https://raw.githubusercontent.com/jeekpark/jeekpark.github.io/main/assets/images/posts_img/commute-cube/arduini-ide.PNG">

고등학교 때, 아두이노 가지고 놀던 때가 기억이 납니다. 예전에는 많이 투박했던 것 같은데, 이제는 다크모드도 지원하고 꽤 Fancy해졌습니다.

보통 개발자들이 프로젝트 세팅을 한 후에 해보는 것이 콘솔에 Hello World 출력하기 입니다. 세팅이 제대로 이루어졌는지를 확인하는 용도입니다. 하지만 아두이노는 콘솔이 없습니다. 그래서 아두이노는 Hello World 대신에 보드에 내장된 LED Blink(점멸)시키기를 해줍니다.

위의 코드는 LED_BUILTIN을 출력모드로 바꾸고, 1초 간격으로 껐다 켰다를 반복하는 코드입니다.

# 빌드 & 플래시 시키기
우선 가이드에 따라 보드매니저에 json URL을 추가하고 포트를 잡아주도록 합니다.
```
https://dl.espressif.com/dl/package_esp32_index.json
```

<img src="https://raw.githubusercontent.com/jeekpark/jeekpark.github.io/main/assets/images/posts_img/commute-cube/arduino-ide-board-manager.PNG">

```File -> Preferences -> Additional boards manager URLS```에 입력해주시면 됩니다.

<img src="https://raw.githubusercontent.com/jeekpark/jeekpark.github.io/main/assets/images/posts_img/commute-cube/arduino-ide-setting.PNG">


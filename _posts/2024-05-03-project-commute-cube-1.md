---
title: "[IoT] 커뮤트 큐브: 2편 아두이노 세팅 (Wemos D1 R32 ESP32) LED 테스트"
excerpt: "Wemos D1 R32 ESP32 플래시(업로드) 문제 해결하기"

categories:
  - iot-commute-cube
tags:
  - []

permalink: /categories/project/commute-cube/2

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

세팅은 다음과 같습니다.

## 문제 발생 (fatal error (0x13))
코드를 빌드하고, 업로드를 하니 업로드가 되지 않습니다.
```
Sketch uses 236793 bytes (18%) of program storage space. Maximum is 1310720 bytes.
Global variables use 21048 bytes (6%) of dynamic memory, leaving 306632 bytes for local variables. Maximum is 327680 bytes.
esptool.py v4.5.1
Serial port COM3
Connecting......................................

A fatal error occurred: Failed to connect to ESP32: Wrong boot mode detected (0x13)! The chip needs to be in download mode.
For troubleshooting steps visit: https://docs.espressif.com/projects/esptool/en/latest/troubleshooting.html
Failed uploading: uploading error: exit status 2
```
출력 로그는 위와 같습니다.

내용을 보니, 치명적인 문제가 발생해서 작업이 중단되었다고 합니다. ESP32에 연결이 실패되었다고 했고 원인은 잘못된 부트모드가 감지되었다고 합니다.

해결할 수 있는 링크 주소가 있어 들어가보니 해당 문제는 다음과 같이 설명되어있습니다.
```
Wrong boot mode detected (0xXX)! The chip needs to be in download mode.
Communication with the chip works (the ROM boot log is detected), but it is not being reset into the download mode automatically.

To resolve this, check the autoreset circuitry (if your board has it), or try resetting into the download mode manually. See Manual Bootloader for instructions.

```

메모리를 플래시할 때, 자동으로 다운로드 모드가 리셋되어야하는데 작동되지 않아서 생기는 문제라고 합니다.

검색을 계속 해보니 수동으로 다운로드 모드 전환하는 방법을 찾았습니다. 제대로된 방법은 GPI00핀을 GND에 연결해서 리셋을 시키라는건데, 

어떤 정체불명의 유튜버는 아두이노 IDE에서 업로드할 때, 기판에 붙어있는 리셋버튼을 눌러주라고 하더군요.

## 문제 해결

정체불명의 유튜버로부터 알아낸 방법으로 해결되었습니다. 업로드할 때, ```Connecting.........```이 출력되는데 이때, 기판의 리셋버튼을 딸깍하고 짧게 눌러주면 다음단계로 넘어가고 메모리에 플래시가 이루어집니다.

그 정체불명의 유튜버는 목소리도 없고 단문장으로만 설명해서 어느나라 사람인지는 모르겠으나 분위기상 인도 공대 형님인 것 같았습니다. 인도는 어떤 나라일까요? 배울 점이 많습니다.

빌드와 업로드가 정상적으로 이루어졌고 시리얼 통신으로 문자열도 잘 찍힙니다. 

다음편은 와이파이 테스트로 돌아오겠습니다!
---
title: "[Unity] 유니티 비주얼스튜디오 연동 오류 해결법" 

categories:
  - Unity
tags:
  - [Game Engine, Visual Studio]


toc: true
toc_sticky: true
#목차 생성 여부

published: true
#글 공개 여부

date: 2022-01-24T00:00:00+09:00
lastmod: 2022-06-06T10:27:00+09:00
---

이 글은 유니티 비주얼스튜디오 연동 오류 해결법을 정리한 글입니다
{: .notice--warning}

## 📌 해결법 1 : 유니티 설정에 비주얼 스튜디오가 제대로 연결 되어 있는지 확인하자.

<br>

- **유니티**에서 `Edit` -> `Preferences` -> `External Tools`로 가보자.
  
<img src="https://raw.githubusercontent.com/reoul/reoul.github.io/main/assets/images/postImage/unity-2-1.png" width="60%">

- 이미지 속에 **빨간 줄로 그어져있는 부분**에서 <u>External Script Editor가 Visual Studio로 설정 되어있는지</u> 확인 해보자.

- 만약 <u>정상적으로 설정 되어있다면</u> **해결법 2**를 사용해보자

<br>

## 📌 해결법 2 : 비주얼 스튜디오에 Unity를 사용한 게임 개발이 체크 되어있는지 확인하자.

- **Visual Studio Installer**를 <u>실행해서 현재 사용하고 있는 비주얼 스튜디오 수정 버튼을 누른다.</u>

<img src="https://raw.githubusercontent.com/reoul/reoul.github.io/main/assets/images/postImage/unity-2-2.png" width="60%">

- 중간에 `게임`에서 `Unity를 사용한 게임 개발`의 체크박스가 체크 되어있으면 <u>해제하고 오른쪽 하단에 수정을 누른다.</u>

<img src="https://raw.githubusercontent.com/reoul/reoul.github.io/main/assets/images/postImage/unity-2-3.png" width="60%">

- 수정이 완료 된 다음 체크 해제된 체크 박스를 <u>다시 클릭하고 오른쪽 하단에 수정을 누른다.</u>

- 수정이 완료 된 다음 <u>유니티도 종료했다가 다시 켜보자.</u>

<br>

## 📎 만약 정상적으로 작동하는데 코드에 에러표시가 뜰때가 있다면

<img src="https://raw.githubusercontent.com/reoul/reoul.github.io/main/assets/images/postImage/unity-2-4.png" width="60%">

- **오른쪽 솔루션 탐색기**에서 `새로고침` 버튼을 눌러보도록 하자.

***
<br>

    💻 열심히 공부해서 작성 중이니 오류나 틀린 부분이 있을 경우 
      언제든지 댓글 혹은 메일로 알려주시면 감사하겠습니다! 😸

[맨 위로 이동하기](#){: .btn .btn--primary }{: .align-right}
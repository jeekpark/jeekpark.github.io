---
title: "[Project] 2022 PlayX4 프로젝트" 

categories:
  - Project
tags:
  - [Unity]


toc: true
toc_sticky: true
#목차 생성 여부

published: true
#글 공개 여부

date:       2022-10-04T12:15:00+09:00
lastmod:    2022-10-04T12:15:00+09:00
---

이 글은 학교에서 2022 PlayX4 프로젝트를 하면서 정리한 글입니다
{: .notice--warning}

<br>

## 프로젝트 소개

- 학교에서 유니티 게임 제작을 위한 실무 경험과 협업 경험을 쌓기 위한 팀 프로젝트
- 프로젝트 인원 : 4명 (메인 프로그래머, 보조 프로그래머, 아트, 사운드)
  - 내 역할 : 팀장, 메인 프로그래머, 기획

## 프로젝트 기간

- 2022.03 ~ 2022.05 PlayX4 제작 기간
- 2022.06 ~ 2022.07 인디크래프트 준비

## 깃허브 링크

[![Readme Card](https://github-readme-stats.vercel.app/api/pin/?username=reoul&repo=Old-Project-Code)](https://github.com/reoul/Old-Project-Code)

## 플레이 영상

<iframe width="1280" height="720" src="https://www.youtube.com/embed/Z7LiuODtMRI" title="Moving Archer 소개 영상" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

## 다양한 시도 및 구현

- `Xml` 문서로 외부에서 세팅값 설정할 수 있게 구현
- `커스텀에디터`로 작업에 도움되는 툴 제작
- `리플랙션`으로 코드 간결화
- `인터페이스`와 `추상 클래스`의 도입으로 확장성 고려

## 문제와 해결법

- 진동을 Update에서 호출했는데 갑자기 한쪽이 진동 안되고, 일정 이상 진동세기가 올라가면 소리 커지면서 일정한 진동을 유지 못했음
  - 해결법 : 진동을 매 프레임 호출하지 않고 0.1 초마다 호출하게 구현함

<br>

- 이 게임은 실제 사람이 몸을 움직여 적의 공격을 피해야 하는데 VR을 장착하고 실제 움직여보니 실제보다 덜 움직이는 것처럼 보였음
  - 해결법 : [CameraRig] 오브젝트의 Scale을 (1.3f, 1f, 1.3f)로 설정하니 VR을 장착하고 움직여도 이질감이 안생김

<br>

- 나무와 나뭇잎에 DissolveMat을 적용하니 프레임이 5 이하로 떨어졌음.
  - 원인 : 나뭇잎이 적어도 몇 천개가 있을거고 그 많은 나뭇잎을 일일이 연산해서 프레임이 떨어지는 것으로 보임
  - 해결법 : 나뭇잎 하나하나 계산하는 것을 DissolveMatAll 스크립트를 작성하여 BoxCollider 하나와 스크립트 한개가 나무 하나를 담당하게 하여 성능을 높임 
  
<br>

- 나무 프리팹에도 DissolveMat을 넣었는데 나무 하나에 나무잎이 너무 많이 시간이 오래 걸린다
  - 해결법 : `커스텀에디터`로 작업 툴을 제작

<br>

***
<br>

    💻 열심히 공부해서 작성 중이니 오류나 틀린 부분이 있을 경우 
      언제든지 댓글 혹은 메일로 알려주시면 감사하겠습니다! 😸

[맨 위로 이동하기](#){: .btn .btn--primary }{: .align-right}
---
title: "[Project] 2021 지스타 프로젝트" 

categories:
  - Project
tags:
  - [Unity]


toc: true
toc_sticky: true
#목차 생성 여부

published: true
#글 공개 여부

date:       2022-10-03T10:23:00+09:00
lastmod:    2022-10-04T09:50:00+09:00
---

이 글은 학교에서 2021 지스타 프로젝트를 하면서 정리한 글입니다
{: .notice--warning}

<br>

## 프로젝트 소개

- 학교에서 유니티 게임 제작을 위한 실무 경험과 협업 경험을 쌓기 위한 팀 프로젝트
- 프로젝트 인원 : 3명 (프로그래머, 아트, 사운드 1명씩)
  - 내 역할 : 팀장, 메인 프로그래머, 기획

## 프로젝트 기간

- 2021.09 ~ 2021.11

## 깃허브 링크

[![Readme Card](https://github-readme-stats.vercel.app/api/pin/?username=reoul&repo=Old-Project-Code)](https://github.com/reoul/Old-Project-Code)

## 플레이 영상

<iframe width="1280" height="720" src="https://www.youtube.com/embed/nGTS4jPmDTU" title="Card Labyrinthos 소개 영상" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

## 다양한 시도 및 구현

- `ScriptableObject`를 사용한 데이터 관리
- `커스텀에디터`를 활용해 팀원과 원활한 협업 추구
- `DOTween`을 사용한 애니메이션 처리
- `코루틴`을 사용해서 일관된 순서의 로직 구현 (yield return StartCoroutine() 사용)

## 문제와 해결법

- 보여지는 이펙트와 사운드 간의 시간차가 발생
  - 원인 : 이펙트가 빠르게 사라지는 것과 사운드의 처음과 중간 부분의 텀이 있어서 소리가 느리게 들림
  - 해결법 : 사운드를 먼저 출력하고 이펙트 오브젝트를 일정 시간 딜레이 시켜서 생성되게 구현

<br>

- 씬을 이동할 때 페이드아웃, 페이드인 효과를 구현했는데 각 구간마다 순서를 지켜야 하는 로직같은 경우 코드가 너무 복잡해짐
  - 해결법 : 코루틴에서 yield return StartCoroutine() 사용하면 해당 코루틴이 다 끝나야 다음 코드로 진행이 되서 FadeOut, FadeIn 전용 코루틴을 따로 만듬

<br>

***
<br>

    💻 열심히 공부해서 작성 중이니 오류나 틀린 부분이 있을 경우 
      언제든지 댓글 혹은 메일로 알려주시면 감사하겠습니다! 😸

[맨 위로 이동하기](#){: .btn .btn--primary }{: .align-right}
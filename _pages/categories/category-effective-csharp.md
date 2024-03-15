---
title: "Effective C# 정리"
layout: archive
permalink: categories/Effective-CSharp
author_profile: true
sidebar_main: true
---

<!-- 타이틀 밑에 설명 -->
Bill Wagner 님의 Effective C#의 책 내용을 정리한 카테고리입니다
<!-- /설명 -->

<!-- 공백이 포함되어 있는 카테고리 이름의 경우 site.categories['a b c'] 이런식으로! -->

***

{% assign posts = site.categories['Effective-CSharp'] %}
{% for post in posts %} {% include archive-single2.html type=page.entries_layout %} {% endfor %}
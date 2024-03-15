---
title: "완성된 프로젝트"
layout: archive
permalink: categories/project
author_profile: true
sidebar_main: true
---

<!-- 공백이 포함되어 있는 카테고리 이름의 경우 site.categories['a b c'] 이런식으로! -->

***

<!-- [![Readme Card](https://github-readme-stats.vercel.app/api/pin/?username=ansohxxn&repo=coding-test)](https://github.com/ansohxxn/coding-test) -->

{% assign posts = site.categories['Project'] %}
{% for post in posts %} {% include archive-single2.html type=page.entries_layout %} {% endfor %}
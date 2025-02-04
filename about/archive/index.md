---
layout: page
title: Arkiv– detta har redan hänt
description: TODO
permalink: /about/archive
---

# Arkiv– detta har redan hänt

{% assign postsByYear = site.pages | where: "layout", "post" | group_by_exp: "post", "post.date | date: '%Y'" %}

{% for year in postsByYear %}
## {{ year.name }}

{% for post in year.items %}

<article class="post preview" markdown="1">
### {{ post.title }}
{{ post.description }}

{% if post.image %}
![{{ post.title }}]({{ post.image }})
{% endif %}

  <a class="full-post" href="{{ post.url }}">Läs mer</a>
</article>

{% endfor %}
{% endfor %}
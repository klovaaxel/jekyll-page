---
layout: page
title: Galleri/Projekt
description: Här finns bilder och länkar till olika projekt och gallerier av Lisa Plommon
---

# Galleri/Projekt

Här skall det in bilder och länkar

{% capture gallery_projects %}
    {% for page in site.pages %}
        {% if page.layout == 'project' %}
            {% if forloop.first == false %}, {% endif %}
            {{ page.cover_image }} | {{ page.title }} | {{ page.url }}
        {% endif %}
    {% endfor %}
{% endcapture %}

{% gallery gallery_projects %}

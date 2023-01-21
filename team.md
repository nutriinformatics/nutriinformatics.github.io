---
layout: infopage
title: Team
banner:
  image: "/assets/images/banners/csm.jpg"
# sidebar: []
---

<div>
{% for person_id in site.data.team["_index"] %}
{% assign person = site.data.team[person_id] %}
  <section>
  <div style="float:left">
     <img src="{{ person.image.src }}" alt="{{ person.name}}" align="left" style="vertical-align:top;margin:5px 15px 15px 0px"> 
  </div>
  
  <div style="width:100%;min-width:390px">
    <h4 id="{{ person.name | cgi_escape }}">{{ person.name }}</h4>
   <i>{{ person.description }}</i>
   <div>
     <b>Contact: </b>
     <a href="mailto:{{ person.email }}" title="Email">Email</a>
     &#xb7;
     <a href="tel:{{ person.tel }}" title="Phone contact number">Phone</a>
   </div>
   
   {% if person contains "proj_title" %}
   <br>
   <div>
     Current project:<br>
     <i>{{ person.proj_title }}</i>
   </div>
   {% endif %}
  </div>
  
  {% if person contains "research_interests" %}
  <div style="width:100%;clear:left">
    <blockquote>
      <b>Research interests</b>
      <ul>
        {% for item in person.research_interests %}
        <li> {{ item }}</li>
        {% endfor %}
      </ul>
    </blockquote>
  </div>
  {% endif %}

  </section>
  <hr style="clear:left">
{% endfor %}

  
</div>

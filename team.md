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
    <div style="margin: 5px 0px 15px 0px">
    
    <div style="float: left;width: 175px">
      <img src="{{ person.image.src }}" alt="{{ person.name}}" align="left" style="vertical-align:top;margin:5px 15px 15px 0px"> 
    </div>
  
    <div style="min-width: 210px;overflow: hidden;vertical-align: top">
      <h4 id="{{ person.name | cgi_escape }}" style="margin:5px 0px">{{ person.name }}</h4>
     <i>{{ person.description }}</i>
     <br><br><b>Contact: </b>
     <a href="mailto:{{ person.email }}" title="Email">Email</a>
     &#xb7;
     <a href="tel:{{ person.tel }}" title="Phone contact number">Phone</a>
   
     {% if person contains "proj_title" %}
     <br><br>
     Current project:<br>
     <i>{{ person.proj_title }}</i>
     {% endif %}
    </div>
    
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

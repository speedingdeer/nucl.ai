---
---


$ ->

  $("section.topics titlebar h2").click ->
      $('html, body').animate({
        scrollTop: $("section.topics").offset().top
      }, config.header.scrollSpeed)
      return false
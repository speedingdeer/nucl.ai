---
---


$ ->

  $("section.about titlebar h2").click ->
      $('html, body').animate({
        scrollTop: $("section.about").offset().top
      }, config.header.scrollSpeed)
      return false
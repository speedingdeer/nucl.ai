---
---

$(window).load ->
  # make background gif animation to referesh each time the page is loaded
  backgroundImage = $("section.splash-screen").css('background-image')
  $("section.splash-screen").css('background-image', backgroundImage.split(".gif")[0] + ".gif" + "?time=" + Date.now() + backgroundImage.split(".gif")[1])

$ ->
  $('logo-wrap').addClass("rotated")
  $('logo-wrap').removeClass("opacity0")
  $('titles').removeClass("opacity0")
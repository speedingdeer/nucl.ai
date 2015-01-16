---
---


$ ->

  # slide conference h2 after logo slide in
  $('splash h1').one animate.onAnimatedEnd, ->
    $('splash h2').removeClass("transparent")
    $('splash h2').addClass("animated bounceInLeft")

---
---

effectIn = "flipInX"
effectOut = "flipOutX"

$ ->
  testimonials = $(".testimonial").toArray()
  idxCurrent = 0

  select = () ->
    $(testimonials[idxCurrent]).removeClass(effectIn)
    $(testimonials[idxCurrent]).addClass(effectOut)
    if $(testimonials[idxCurrent + 1]).length == 1
      $(testimonials[idxCurrent + 1]).removeClass(effectIn)
      $(testimonials[idxCurrent + 1]).addClass(effectOut)
    $(testimonials[idxCurrent]).one animate.onAnimatedEnd, ->
      $(testimonials[idxCurrent]).removeClass("selected")
      if $(testimonials[idxCurrent + 1]).length == 1
        $(testimonials[idxCurrent + 1]).removeClass("selected")
      idxCurrent+=2
      if idxCurrent >= testimonials.length then idxCurrent = 0
      $(testimonials[idxCurrent]).removeClass(effectOut)
      $(testimonials[idxCurrent]).addClass("selected " + effectIn)
      if $(testimonials[idxCurrent + 1]).length == 1
        $(testimonials[idxCurrent + 1]).removeClass(effectOut)
        $(testimonials[idxCurrent + 1]).addClass("selected " + effectIn)
      change()

  change = () ->
    setTimeout select, 10000

  change()
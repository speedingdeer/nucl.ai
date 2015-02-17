---
---

effectIn = "flipInX"
effectOut = "flipOutX"
SHORT_INTERVAL = 450
LONG_INTERAL = 10000

$ ->
  testimonials = $(".testimonial").toArray()
  idxCurrent = 0

  change = () ->
    interval = LONG_INTERAL
    if idxCurrent % 2 != 0 then interval = SHORT_INTERVAL
    setTimeout select, interval

  next = (idx, incBy) ->
    idx += incBy
    if idx == testimonials.length then return 0
    if idx == testimonials.length + 1 then return 1
    return idx
  ###
  ## one after the other
  select = () ->
    $(testimonials[idxCurrent]).removeClass(effectIn)
    $(testimonials[idxCurrent]).addClass(effectOut)
    $(testimonials[idxCurrent]).one animate.onAnimatedEnd, ->
      $(testimonials[idxCurrent]).removeClass("selected")
      nextIdx = next(idxCurrent, 2)
      $(testimonials[nextIdx]).removeClass(effectOut)
      $(testimonials[nextIdx]).addClass("selected " + effectIn)
      idxCurrent =  next(idxCurrent, 1)
      change()
  ###
  ###
  ## simultaneous
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
  ###

  ## domino
  select = () ->
    $(testimonials[idxCurrent]).removeClass(effectIn)
    $(testimonials[idxCurrent]).addClass(effectOut)
    wasCurrent = idxCurrent
    nextIdx = next(idxCurrent, 2)
    idxCurrent =  next(idxCurrent, 1)
    change()
    $(testimonials[wasCurrent]).one animate.onAnimatedEnd, ->
      $(testimonials[wasCurrent]).removeClass("selected")
      $(testimonials[nextIdx]).removeClass(effectOut)
      $(testimonials[nextIdx]).addClass("selected " + effectIn)

  change()
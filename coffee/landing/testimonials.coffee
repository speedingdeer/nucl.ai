effectIn = "flipInX"
effectOut = "flipOutX"
SHORT_INTERVAL = 450
LONG_INTERAL = 10000

animationType = ""

$ ->
  sections = []
  $("section.testimonials").each ->

    testimonials = $(@).find(".testimonial").toArray()

    if $(@).hasClass("domino") # select domino layout
      idxCurrent = 0
      pair = 0
      change = () ->
        interval = LONG_INTERAL
        if idxCurrent % 2 != 0 then interval = SHORT_INTERVAL
        setTimeout select, interval

      next = (idx, incBy) ->
        idx += incBy
        if idx == testimonials.length then return 0
        if idx == testimonials.length + 1 then return 1
        return idx

      select = () ->
        # domino
        if pair == 2 then return change() # push back to queue if animations haven't finished yet
        pair += 1
        $(testimonials[idxCurrent]).removeClass(effectIn)
        $(testimonials[idxCurrent]).addClass(effectOut)
        wasCurrent = idxCurrent
        nextIdx = next(idxCurrent, 2)
        idxCurrent =  next(idxCurrent, 1)
        change()
        $(testimonials[wasCurrent]).one animate.onAnimatedEnd, (data) ->
          if animationType == ""  # use only fist animation type
            animationType = data.type
          else if animationType != data.type then return

          pair-=1;
          $(testimonials[wasCurrent]).removeClass("selected")
          $(testimonials[nextIdx]).removeClass(effectOut)
          $(testimonials[nextIdx]).addClass("selected " + effectIn)

      return change()

    #get testimonials one by one
    idxCurrent = 0

    select = () ->
      $(testimonials[idxCurrent]).removeClass(effectIn)
      $(testimonials[idxCurrent]).addClass(effectOut)
      $(testimonials[idxCurrent]).one animate.onAnimatedEnd, (data) ->
        if animationType == ""  # use only fist animation type
            animationType = data.type
        else if animationType != data.type then return

        $(testimonials[idxCurrent]).removeClass("selected")
        idxCurrent = if idxCurrent == testimonials.length - 1 then idxCurrent = 0 else idxCurrent + 1
        $(testimonials[idxCurrent]).removeClass(effectOut)
        $(testimonials[idxCurrent]).addClass("selected " + effectIn)
        setTimeout select, LONG_INTERAL

    select()
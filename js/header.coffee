---
---

### 
Not used cause currently there is no header
$ ->

  headerHeight = $("header").height()

  # scroll on menu position clicked
  $(".scrolllink").each ->
    link = $(this)
    link.click ->
      scrollTo = $(link.attr("href")).offset().top - headerHeight
      $('html, body').animate({
        scrollTop: scrollTo
      }, config.header.scrollSpeed)
      return false

  # calculate visible header elements

  # members
  init = true

  # helper methods
  showHeader = ->
    if not $("header").hasClass("opacity0") then return
    $("header").addClass("animated fadeIn")
    $("header").removeClass("opacity0")
    $('header').one animate.onAnimatedEnd, -> 
      $(this).removeClass("animated fadeIn")
      if init # if header first time loaded animate it
        $("header a.nuclAi-go-top").addClass("animated bounceInLeft")
        $("header a.nuclAi-go-top").removeClass("transparent")
        $("header a.nuclAi-go-top").one animate.onAnimatedEnd, -> $(this).removeClass("animated bounceInLeft")
        init = false

  hideHeader = ->
    $("header").removeClass("aniamted fadeIn") # always hide immediate
    $("header").addClass("opacity0")

  detectPosition = ->
    scrollTop = $(window).scrollTop()
    # show/hide header
    offset = $("navigation").offset()
    # check if is menu is unvisible with 1px tolerance
    # set active menu element
    # commented out - there is no menu yet
    action = if offset.top + $("navigation").height() - scrollTop <= 1 then showHeader else hideHeader
    action()

    # set active menu element
    sections = []
    $("section").each ->
      section = $(this)
      position = section.offset().top + ( section.height() / 2 )   # section center position
      abs = Math.abs(scrollTop - position + headerHeight + 1)
      sections.push({ "positon": position, "id": section.attr('id'), "abs": abs })

    sections = sections.sort (a, b) ->  a.abs > b.abs
    $("header a.visible").each -> $(this).removeClass("visible")
    $("header a[href=#" + sections[0].id + "]").addClass("visible")

  $(window).scroll(detectPosition)
  detectPosition()
###



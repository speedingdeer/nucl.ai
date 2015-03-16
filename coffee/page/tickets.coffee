$ ->
  hoverIn = () ->
    hoverToggle("in", $(@)) 

  hoverOut = () ->
    hoverToggle("out", $(@))

  hoverToggle = (inOut, cell) ->
    wrap = cell.parent().parent()
    if cell.parent().hasClass("invisible") then return
    cell.parent().find(".centered-cell").each ->
      if ! $(@).parent().hasClass("titlerow") && ! $(@).parent().hasClass("invisible")
        if inOut == "in" then $(@).addClass("hovered")
        if inOut == "out" then $(@).removeClass("hovered")
    if cell.hasClass("all-access")
      wrap.find(".all-access .centered-cell").each ->
        if inOut == "in" then $(@).addClass("hovered")
        if inOut == "out" then $(@).removeClass("hovered")
    if cell.hasClass("conference")
      wrap.find(".conference .centered-cell").each ->
        if inOut == "in" then $(@).addClass("hovered")
        if inOut == "out" then $(@).removeClass("hovered")


  $("div.table").hover hoverIn, hoverOut

  scrollToEventbriteTickets = () ->
    $('html, body').animate({
        scrollTop: $("#buy-tickets").offset().top
    }, config.header.scrollSpeed)

  $("#buy-tickets-link").click ->
    scrollToEventbriteTickets()
    return false

  $(".all-access .centered-cell, .conference .centered-cell").click scrollToEventbriteTickets

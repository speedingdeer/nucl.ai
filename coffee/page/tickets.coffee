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
        scrollTop: $("#purchase").offset().top
    }, config.header.scrollSpeed)

  $(".buy-tickets-link").click ->
    scrollToEventbriteTickets()
    return false

  if $(".tickets.prices").length == 0 then return
  $(".tickets.prices .centered-cell, .conference-good .centered-cell").click ->
    
    if $(@).parent().parent().attr("name") == "Access to the Main Amphitheatre"
      window.location = "/program/overview/#main-amphitheatre"
    if $(@).parent().parent().attr("name") == "Access to the Masterclass Room"
      window.location = "/program/overview/#masterclass-room"
    if $(@).parent().parent().attr("name") == "Access to the Open Laboratory"
      window.location = "/program/overview/#open-laboratories"
    scrollToEventbriteTickets()

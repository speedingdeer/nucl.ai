root = exports ? this # global

$ ->

  if $("section.tickets").length == 0 then return

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
    console.log "click"
    if $("#purchase").length == 0 then window.location = "/tickets/#purchase"
    return root.scroll "purchase", $("#purchase").offset().top

  $(".buy-tickets-link").click ->
    scrollToEventbriteTickets()
    return false

  if $(".tickets.prices, .tracks-content.tickets").length == 0 then return
  $(".tickets.prices .centered-cell, .conference-good .centered-cell, .tracks-content.tickets .centered-cell").click ->
    
    if $(@).parent().parent().attr("name") == "Access to the Main Amphitheatre"
      window.location = "/program/overview/#main-amphitheatre"
      return false
    if $(@).parent().parent().attr("name") == "Access to the Masterclass Room"
      window.location = "/program/overview/#masterclass-room"
      return false
    if $(@).parent().parent().attr("name") == "Access to the Open Laboratory"
      window.location = "/program/overview/#open-laboratories"
      return false
    scrollToEventbriteTickets()

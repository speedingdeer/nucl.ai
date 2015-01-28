---
---

$ ->

    ## draw line between selected thumbnail and text
  paper = Raphael('section-topics', "100%", "100%") # draw within the whole section

  clearLine = () ->
    $("svg path").remove()

  drawLine = () ->
    if $("thumbnail.selected").length == 0 then return
    startY = $("thumbnail.selected").offset().top - $("section.topics").offset().top + $("thumbnail.selected").height()
    startX = $("thumbnail.selected").offset().left + $("thumbnail.selected").width() / 2
    endY = startY + 150
    ## @TODO remove hardcoded offsetY value
    # draw leftLine
    if $("thumbnail.selected").hasClass("left") then endX = startX + 300
    if $("thumbnail.selected").hasClass("right") then endX = startX - 300
    if $("thumbnail.selected").hasClass("middle") then endY = endY - 42

    line = paper.path("M" + startX + " " + startY + "L " + startX + " " + endY + " L " + endX + " " + endY)

  drawLine();
  
  ## listen when window resizes to clear lines and redrew them once finished
  resizeEnd = null
  $(window).resize ->
    clearLine()
    clearTimeout(resizeEnd)
    resizeEnd = setTimeout(drawLine,100)


  ## hide/show overlay on animation start/end
  selected = null
  selectedTxt = null
  selectedTitle = null

  $("thumbnail").each ->
    thumbnail = $(this)
    if thumbnail.hasClass("selected")
      # discover selected by default
      selected = thumbnail
      selectedTxt = $(".description[name='" + selected.attr('name') + "']")
      selectedTitle = $("item.thumbnail .thumbnail-title[name='" + selected.attr('name') + "']")

    initialHeight = thumbnail.height()
    overlay = thumbnail.children("overlay")

    thumbnail.click ->
      thumbnail.toggleClass("selected")
      $(".description[name='" + thumbnail.attr('name') + "']").toggleClass("selected")
      $("item.thumbnail .thumbnail-title[name='" + thumbnail.attr('name') + "']").toggleClass("selected")
      if thumbnail != selected
        if selected != null
          selected.toggleClass("selected")
          selectedTxt.toggleClass("selected")
          selectedTitle.toggleClass("selected")
          selected.children("overlay").hide() # hide overlay during the animation
        selected = thumbnail
        selectedTxt = $(".description[name='" + selected.attr('name') + "']")
        selectedTitle = $("item.thumbnail .thumbnail-title[name='" + selected.attr('name') + "']")
      else 
        selected = null
        selectedTitle - null
        selectedTxt = null
      overlay.hide();
      clearLine();

    thumbnail.bind animate.onTransitonEnd, (event) ->
      if event.originalEvent.propertyName == "height"
        overlay.show()
        drawLine();

  ## color name / surname
  applyColors = (title, text, last) ->
    text =  "<span class='colored'>" + text + "</span>"
    if last then text += last
    title.html(text)

  $("section.topics item .thumbnail-title").each ->
    title = $(this)
    titleText = title.text()
    words = titleText.trim().split(/\s+/)
    if words.length == 1
      return applyColors(title, words[0])

    text = ""
    for word in words.slice(0, -1)
      text += word + " "
    applyColors(title, text, words.slice(-1))


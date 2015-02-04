---
---

$ ->

  ## if section isn't included - don't bother
  if $("section.topics").length == 0 then return

  ## draw line between selected thumbnail and text
  paper = Raphael('section-topics', "100%", "100%") # draw within the whole section


  ## get original thumbnail size
  originalHeight = $("thumbnail").first().height()

  clearLine = () ->
    $("svg path").remove()

  drawLine = (thumbnail) ->
    thumbnail = $("thumbnail.selected")
    if thumbnail.length == 0 then return
    title = $("item.description[name='" + thumbnail.attr('name') + "'] .thumbnail-title")

    startY = thumbnail.offset().top - $("section.topics").offset().top + thumbnail.height()
    startX = thumbnail.offset().left + thumbnail.width() / 2

    #check if line intersects title
    if thumbnail.hasClass("left") and title.offset().left <= startX then return
    if thumbnail.hasClass("right") and title.offset().left >= startX then return

    #calculate vertical line
    endY = title.offset().top + title.outerHeight() - $("section.topics").offset().top
    
    # preserve original values
    originalEndY = endY

    # calculate horizontal leftLine
    if thumbnail.hasClass("left") then endX = title.offset().left + title.width()
    if thumbnail.hasClass("right") then endX = title.offset().left
    if thumbnail.hasClass("middle") then endY = endY - title.outerHeight()

    line = paper.path("M" + startX + " " + startY + "L " + startX + " " + endY + " L " + endX + " " + endY)

    if thumbnail.hasClass("middle")
      #draw disconnected horizontal line
      paper.path("M " + title.offset().left + " " + originalEndY + "L " + (title.offset().left + title.width()) + " " + originalEndY)

  drawLine()

  setThumbnailSize = () ->
    $("thumbnail-wrap").each ->
      wrap = $(this)
      wrap.height(wrap.width())


  setThumbnailSize()
  ## listen when window resizes to clear lines and redrew them once finished
  resizeEnd = null
  $(window).resize ->
    clearLine()
    clearTimeout(resizeEnd)
    setThumbnailSize()
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

    thumbnail.click ->
      thumbnail.toggleClass("selected")
      $(".description[name='" + thumbnail.attr('name') + "']").toggleClass("selected")
      $("item.thumbnail .thumbnail-title[name='" + thumbnail.attr('name') + "']").toggleClass("selected")
      if thumbnail != selected
        if selected != null
          selected.toggleClass("selected")
          selectedTxt.toggleClass("selected")
          selectedTitle.toggleClass("selected")
          ## if selected has minimum size show overlay, otherwise wait for it
          if selected.height() == originalHeight
             selected.children("overlay").show()
          else
            selected.one animate.onTransitonEnd, (event) ->
              if event.originalEvent.propertyName == "width" and selected.height() == originalHeight
                selected.children("overlay").show()

        selected = thumbnail
        selectedTxt = $(".description[name='" + selected.attr('name') + "']")
        selectedTitle = $("item.thumbnail .thumbnail-title[name='" + selected.attr('name') + "']")
      else 
        selected = null
        selectedTitle - null
        selectedTxt = null
      clearLine()
      drawLine()


  ## color name / surname
  ## @TODO: move me to liquid filter
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


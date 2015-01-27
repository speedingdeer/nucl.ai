---
---

$ ->

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

    thumbnail.bind animate.onTransitonEnd, (event) ->
      if event.originalEvent.propertyName == "height"
        overlay.show()

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
---
---

$ ->
  selected = null
  $("thumbnail").each ->
    thumbnail = $(this)
    initialHeight = thumbnail.height()
    overlay = thumbnail.children("overlay")

    thumbnail.click ->
      thumbnail.toggleClass("selected")
      if thumbnail != selected
        if selected != null
          selected.toggleClass("selected")
          selected.children("overlay").hide() # hide overlay during the animation
        selected = thumbnail
      else selected = null
      overlay.hide();

    thumbnail.bind animate.onTransitonEnd, (event) ->
      if event.originalEvent.propertyName == "height"
        overlay.show()

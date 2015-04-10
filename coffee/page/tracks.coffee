root = exports ? this # global

$ ->
  if $("#section-tracks-menu").length > 0
    thumbnails = new Thumbnails "section-tracks-menu", true, true

  if $("#track-content").length > 0
    thumbnails = new Thumbnails "track-content", true, true

  if $("#section-tracks-people").length > 0
    thumbnails = new Thumbnails "section-tracks-people", true, false

  $("h3 a, li a.scrollable").click ->
    id = $(@).attr("href").split("#")[1]
    root.scroll id, $("#" + id).offset().top
    return false

  $(".tracks-people .track-topic a").click ->
    id = $(@).attr("href").split("#")[1]
    if $("#" + id).length > 0
      root.scroll id, $("#" + id).offset().top
    return false
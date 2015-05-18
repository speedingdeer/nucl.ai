root = exports ? this # global

$ ->
  if $("#section-tracks-menu").length > 0
    thumbnails = new Thumbnails "section-tracks-menu", true, true

  if $("#track-content").length > 0
    thumbnails = new Thumbnails "track-content", true, true

  if $("#section-tracks-people").length > 0
    thumbnails = new Thumbnails "section-tracks-people", true, true


  $("h3 a, li a.scrollable, .tracks-people .track-topic a, .talks-list a").click ->
    id = $(@).attr("href").split("#")[1]
    if $(@).hasClass("wip") then return false
    if $("#" + id).length > 0
      root.scroll id, $("#" + id).offset().top
      return false
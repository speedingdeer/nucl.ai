$ ->
  if $("#section-tracks-menu").length > 0
    thumbnails = new Thumbnails "section-tracks-menu", true, true

  if $("#track-content").length > 0
    thumbnails = new Thumbnails "track-content", true, true

  if $("#section-tracks-people").length > 0
    thumbnails = new Thumbnails "section-tracks-people", true, false

  $("h3 a, .scrollable").click ->
    id = $(@).attr("href").split("#")[1]
    $('html, body').animate({
        scrollTop: $("#" + id).offset().top,
    },
    ).promise().done ->
        if history.replaceState
          history.replaceState null, null, "#" + id
          setTimeout ->
            root.scrollLocked = false
          , 300
    return false
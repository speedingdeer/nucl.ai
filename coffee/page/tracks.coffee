$ ->
  if $("#section-tracks-menu").length > 0
    thumbnails = new Thumbnails "section-tracks-menu", true, true, false

  if $("#track-content").length > 0
    thumbnails = new Thumbnails "track-content", true, true, false

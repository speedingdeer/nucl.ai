$ ->
  if $("#section-tracks-menu").length > 0
    thumbnails = new Thumbnails "section-tracks-menu", true, true

  if $("#track-content").length > 0
    thumbnails = new Thumbnails "track-content", true, true

  if $("#section-tracks-people").length > 0
    thumbnails = new Thumbnails "section-tracks-people", true, true
$ ->
  if $("#section-people-track-chairs").length > 0
    thumbnails = new Thumbnails "section-people-track-chairs", true, false, false
  if $("#section-people-speakers").length > 0
    thumbnails = new Thumbnails "section-people-speakers", true, false, false
  if $("#section-people-organizers").length > 0
    thumbnails = new Thumbnails "section-people-organizers", true, false, false
  if $("#section-people-advisors").length > 0
    thumbnails = new Thumbnails "section-people-advisors", true, false, false
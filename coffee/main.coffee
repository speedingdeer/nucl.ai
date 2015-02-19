# detect ios (ios struggles with our font if used both bold and box-shadow)
$(window).load ->
  if navigator.userAgent.match(/(iPad|iPhone|iPod)/g)
    $("html").addClass("ios")
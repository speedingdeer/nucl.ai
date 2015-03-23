# detect ios (ios struggles with our font if used both bold and box-shadow)
$(window).load ->
  if navigator.userAgent.match(/(iPad|iPhone|iPod)/g)
    $("html").addClass("ios")

  $(window).scroll ->
    if window.location.hash != ""
      if history.replaceState
        history.replaceState null, null, ' '

  ## fake click if soemthing selected in url hash
  if (! @selected || @selected.length == 0) && window.location.hash != ""
    selectedId = window.location.hash.substring(1)
    $("#thumbnail-id-" + selectedId).click()

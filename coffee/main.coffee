# detect ios (ios struggles with our font if used both bold and box-shadow)
enableSections = () ->
  if $("grid").length == $("grid.visited").length then return # don't check anything if all sections are enabled 
  bottomEdge = $(window).scrollTop() + $(window).height()
  $("section").each ->
    if $(@).offset().top < bottomEdge
      $(@).find("content, h2").addClass("visited")

$(window).load ->
  if navigator.userAgent.match(/(iPad|iPhone|iPod)/g)
    $("html").addClass("ios")
  $(window).scroll ->
    enableSections()
    if window.location.hash != ""
      if history.replaceState
        history.replaceState null, null, ' '

  enableSections()
enableSections()
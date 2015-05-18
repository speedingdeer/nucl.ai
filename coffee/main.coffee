root = exports ? this # global
root.scrollLocked = false;

# detect ios (ios struggles with our font if used both bold and box-shadow)

scroll = (id, scrollTo) ->
  root.scrollLocked = true
  promise = $('html, body').animate({
      scrollTop: scrollTo
  }, config.header.scrollSpeed, ->
    ).promise()
  promise.done ->
    if history.replaceState
      history.replaceState null, null, "#" + id
      setTimeout ->
        root.scrollLocked = false
      , 300

root.scroll = scroll

enableSections = () ->
  if $("content").length == $("content.visited").length then return # don't check anything if all sections are enabled 
  bottomEdge = $(window).scrollTop() + $(window).height()
  $("section").each ->
    if $(@).offset().top < bottomEdge
      $(@).find("content, h2").addClass("visited")

$(window).load ->
  root.scrollLocked = false;


disableWip = () ->
  $("a.wip").click ->
      return false


$ ->
  if navigator.userAgent.match(/(iPad|iPhone|iPod)/g)
    $("html").addClass("ios")
  $(window).scroll ->
    enableSections()
    if !root.scrollLocked && window.location.hash != ""
      if $(window.location.hash).offset().top * 0.95 > $(window).scrollTop() || $(window.location.hash).offset().top * 1.05 < $(window).scrollTop()  
        if history.replaceState
          history.replaceState null, null, ' '

  enableSections()
  disableWip()

enableSections()

root.disableWip = disableWip
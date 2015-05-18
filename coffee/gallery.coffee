root = exports ? this # global

slideInClass = "fadeInLeftBig"
slideOutClass = "fadeOutRightBig"

descriptionInClass = "fadeInRightBig"
descriptionOutClass = "fadeOutLeftBig"


$ ->

  select = (collection, extras, menu, clicked, inClass, outClass) ->

    slideIn = (selected, collection, inClass, outClass) ->
      if selected.hasClass("selected")  
        selected.addClass(outClass)
        selected.removeClass(inClass)
        selected.addClass(outClass)
        selected.one animate.onAnimatedEnd, ->
          if ! menu.find("item[name='" + selected.attr('name') + "']" ).hasClass("selected")
            # it wasn't reselected meantime
            selected.removeClass("selected")
          if clicked.hasClass("selected")
            # if it's still selected
            selected = collection.find("item[name='" + clicked.attr('name') + "']" )
            selected.removeClass(outClass)
            selected.addClass("selected " + inClass)
            selected.one animate.onAnimatedEnd, ->
              if clicked.hasClass("selected") # if it's still selected
                selected.find("div.cover").removeClass("fadeIn")
                selected.find("div.cover").addClass("fadeOut")

    selected = collection.find("item.selected")
    for extra in extras
      extra.selected = extra.find("item.selected")

    if selected.find("div.cover").hasClass("fadeOut")
      selected.find("div.cover").removeClass("fadeOut")
      selected.find("div.cover").addClass("fadeIn")
      selected.one animate.onAnimatedEnd, ->
        slideIn(selected, collection, slideInClass, slideOutClass)
        for extra in extras
          slideIn(extra.selected, extra, descriptionInClass, descriptionOutClass)
    else 
      slideIn(selected, collection, slideInClass, slideOutClass)
      for extra in extras
          slideIn(extra.selected, extra, descriptionInClass, descriptionOutClass)


  $("gallery").each ->
    galery = $(@)
    menu = galery.find("menu")
    slides = galery.find("slides")
    descriptions = galery.find("descriptions")
    menu.find("item").click ->
      # handle menu
      clicked = $(@)
      selected = menu.find("item.selected")
      if selected.is clicked then return false # no deselect
      selected.removeClass("selected")
      clicked.addClass("selected")
      # something change switch slides
      select slides, [descriptions],  menu, clicked, slideInClass, slideOutClass
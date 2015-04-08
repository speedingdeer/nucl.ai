root = exports ? this # global

slideInClass = "fadeInLeftBig"
slideOutClass = "fadeOutRightBig"

descriptionInClass = "fadeInRightBig"
descriptionOutClass = "fadeOutLeftBig"


$ ->

  

  select = (collection, menu, clicked, inClass, outClass) ->

    selected = collection.find("item.selected")

    slideIn = () ->
      if selected.hasClass("selected")  
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

    if selected.find("div.cover").hasClass("fadeOut")
      selected.find("div.cover").removeClass("fadeOut")
      selected.find("div.cover").addClass("fadeIn")
      selected.find("div.cover").one animate.onAnimatedEnd, slideIn
    else 
      slideIn()


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
      select slides, menu, clicked, slideInClass, slideOutClass
      select descriptions, menu, clicked, descriptionInClass, descriptionOutClass
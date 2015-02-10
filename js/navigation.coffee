---
---

$ ->

  navigation = $(".navigation")
  splash = $("section.splash-screen")

  links = $(".navigation a")
  links.each ->
    @.jQlink = $(@)
    hash = @.jQlink.attr("href").split("#")[1]
    @.jQsection = $("#" + hash)
    @.jQscrollTo = $("#" + hash)
    if hash == "about" then @.jQsection = $("section.about")

  scroll = (link) ->
    $('html, body').animate({
        scrollTop: link.jQscrollTo.offset().top + 1 - navigation.height() # 1 is because offset doesn't have 100% accuracy
    }, config.header.scrollSpeed);

  links.each ->
    @.jQlink.click ->
      linkHref = @.jQlink.attr("href")
      if linkHref.substring(0,1) == "/" # absolute
        return true;

      scroll(@)
      return false;

  selectNavPosition = () ->
    linkToSelect = null
    links.each ->
      if $(window).scrollTop() + navigation.height()  >= -1 + @.jQsection.offset().top and $(window).scrollTop() + navigation.height() < @.jQsection.offset().top + @.jQsection.height()
        if navigation.hasClass("sticky")
          linkToSelect = @.jQlink
    navigation.find("item.selected").removeClass("selected")
    if linkToSelect then linkToSelect.parent().addClass("selected")

  $(window).scroll ->
    if $(this).scrollTop() > splash.height() - navigation.height()
      navigation.addClass("sticky")
    else
      navigation.removeClass("sticky")
    selectNavPosition()


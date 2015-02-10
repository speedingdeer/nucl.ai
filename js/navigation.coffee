---
---

$ ->

  navigation = $(".navigation")
  splash = $("section.splash-screen")

  scroll = (link) ->
    anchor = $(link.attr("name"))
    $('html, body').animate({
        scrollTop: anchor.offset().top - navigation.height()
    }, config.header.scrollSpeed);

  $(".navigation a").each ->
    link = $(this)
    anchor = $(link.attr("href"))

    ##  change sections ids to remove jump effect and maintain load with section (when open from link or different page)
    if anchor.length > 0 # if link can be found
      anchor.attr("id", anchor.attr("id") + "-")

    link.click ->
      linkHref = link.attr("href")
      if linkHref.substring(0,1) == "/" # absolute
        return true;

      scroll(link)
      return true;

  selectNavPosition = () ->
    $(".navigation a").each ->
      link = $(this)
      section = $(link.attr("name"))
      # little exception if link leads to the top, section isn't splash screen - it's about
      if link.attr("name") == "section.splash-screen" then section = $("section.about")
      if $(window).scrollTop() + navigation.height()  >= -1 + section.offset().top and $(window).scrollTop() + navigation.height() < section.offset().top + section.height()
        $(".navigation item.selected").removeClass("selected")
        link.parent().addClass("selected")
        window.location.hash = link.attr("href").split("#")[1]

  $(window).scroll ->
    if $(this).scrollTop() > splash.height() - navigation.height()
      navigation.addClass("sticky")
    else
      navigation.removeClass("sticky")
    selectNavPosition()


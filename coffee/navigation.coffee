$ ->

  navigation = $(".navigation")
  splash = $("section.splash-screen")

  links = $(".navigation a")
  links.each ->
    @.jQlink = $(@)
    hash = @.jQlink.attr("href").split("#")[1]
    @.jQscrollTo = $("#" + hash)
    if !hash || hash == ""
      @.jQsection = []
    else 
      @.jQsection = $("section." + hash)

  scroll = (link) ->
    $('html, body').animate({
        scrollTop: link.jQscrollTo.offset().top
    }, config.header.scrollSpeed);

  expanded = $(".navigation a.expanded")

  links.each ->
    @.jQlink.click ->
      if @.jQlink.hasClass("disabled") then return false;
      if @.jQlink.hasClass("expandable")
        @.jQlink.toggleClass("expanded")
        @.jQlink.parent().toggleClass("expanded")
        if expanded.length == 1 and expanded[0]  != @.jQlink[0]
          expanded.toggleClass("expanded")
          expanded.parent().toggleClass("expanded")
        expanded = $(".navigation a.expanded")
        return false
      linkHref = @.jQlink.attr("href")
      if linkHref.substring(0,1) == "/" # absolute
        return true;
      if expanded.length == 1 
        expanded.toggleClass("expanded")
        expanded.parent().toggleClass("expanded")
        expanded = $(".navigation a.expanded")
      scroll(@)
      return false;

  selectNavPosition = () ->
    linkToSelect = null
    links.each ->
      if @.jQsection.length == 0 then return # don't search for section which doesn't exist
      if $(window).scrollTop() + navigation.height()  >= -1 + @.jQsection.offset().top and $(window).scrollTop() + navigation.height() < @.jQsection.offset().top + @.jQsection.height()
        if navigation.hasClass("sticky")
          linkToSelect = @.jQlink
    navigation.find("item.selected").removeClass("selected")
    if linkToSelect
      if linkToSelect.hasClass("logo")
        # little exception it has wrapper for positioning icons on top of each other - select parent of parent
        linkToSelect.parent().parent().addClass("selected")
      linkToSelect.parent().addClass("selected")

  $(window).scroll ->
    if $(this).scrollTop() > splash.height() - navigation.height()
      navigation.addClass("sticky")
    else
      navigation.removeClass("sticky")
    selectNavPosition()


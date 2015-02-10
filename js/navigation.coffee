---
---

$ ->
  scroll = (link) ->
    anchor = $(link.attr("name"))
    $('html, body').animate({
        scrollTop: anchor.offset().top
    }, config.header.scrollSpeed);

  $(".navigation a").each ->
    link = $(this)
    link.click ->
      linkHref = link.attr("href")
      if linkHref.substring(0,1) == "/" # absolute
        return true;

      anchor = $(link.attr("href"))
      if anchor.length > 0 # if link can be found
        anchor.attr("id", anchor.attr("id") + "-")

      scroll(link)
      return true;
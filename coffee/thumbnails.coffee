root = exports ? this # global


class Thumbnails

  constructor: (sectionId, @animated, @justSize, @drawSvg) ->
    that = @
    @section  = $("#" + sectionId)
    if @section.length != 1 
        console.warn "Can't discover section #{section_selector}"
        return
    ## buid svg
    @paper = Raphael(sectionId, "100%", "100%")
    ## select jquery object
    @svg = @section.find("svg")
    @wraps =  @section.find("thumbnail-wrap")
    @shortBios = @section.find("div.short-bio-wrap")
    @thumbnails = @section.find("a.thumbnail")

    @checkBckgImg()

    $(window).resize ->
      that.setThumbnailSize()
      ## if there is any!
      if that.svg and that.svg.find("path").length > 0
        that.clearLine()
        that.drawLine()

    @thumbnails.each ->
      @.jQthumbnail = $(@)
      @.jQdescription = that.section.find(".description[name='" + $(@).attr('name') + "']")
      @.jQtitle = that.section.find("item.thumbnail .thumbnail-title[name='" + $(@).attr('name') + "']")
      ## change title color on thumbnail hover
      t = @
      t.jQthumbnail.hover () ->
          t.jQtitle.addClass("hover")
        ,
        () ->
          t.jQtitle.removeClass("hover")

    @setThumbnailSize()

    if @justSize
      @thumbnails.each ->
        if @.jQthumbnail.hasClass("disabled")
          @.jQthumbnail.click ->
            return false
        if @.jQthumbnail.hasClass("scrollable")
          @.jQthumbnail.click ->
            id = $(@).attr("href").split("#")[1]
            root.scroll(id, $(".tracks-people #" + id).offset().top).done ->
              if ! $(".tracks-people #thumbnail-id-" + id).hasClass("selected")
                $(".tracks-people #thumbnail-id-" + id).click()
            return false
      return

    @selected = @thumbnails.filter(".selected")
    if @selected.length == 0 then @selected = null
    animated = @animated
    if not @animated then @thumbnailsNotAnimated() 
    if @animated then @thumbnailsAnimated()

    ## fake click if soemthing selected in url hash
    if window.location.hash != ""
      selectedId = window.location.hash.substring(1)
      # check globally if there is no one selected already
      if $("#thumbnail-id-" + selectedId + ".selected").length == 0
        @section.find("#thumbnail-id-" + selectedId).click()


  ## selections / animation

  fadeOut: (t) ->
    t.jQdescription.removeClass("fadeInLeft")
    t.jQdescription.addClass("fadeOutRight")

  fadeIn: (t) ->
    t.jQdescription.addClass("fadeInLeft")
    t.jQdescription.removeClass("fadeOutRight")

  selectThumbnail: (t) ->
    t.jQthumbnail.addClass("selected")
    t.jQtitle.addClass("selected")
    ## select description with delay 
    if not @animated then t.jQdescription.addClass("selected")

  deselectThumbnail: (t) ->
    t.jQthumbnail.removeClass("selected")
    t.jQtitle.removeClass("selected")
    ## deselecy description with delay
    if not @animated then t.jQdescription.removeClass("selected")

  thumbnailsAnimated: ->
    that = @
    @thumbnails.each ->
      t = @ 
      t.jQthumbnail.click ->
        if that.selected
          # there was something selected
          if t == that.selected
            # just deselect
            that.deselectThumbnail(t)
            that.selected = null
            that.clearLine()
            that.fadeOut(t)
            t.jQdescription.one animate.onAnimatedEnd, ->
              if that.selected != t
                # if it's not back selected
                t.jQdescription.removeClass("selected")
          else
            # deselect old one first then select new one
            that.clearLine()
            that.deselectThumbnail(that.selected)
            that.selectThumbnail(t)
            wasSelected = that.selected
            that.selected = t
            if wasSelected.jQdescription.hasClass("fadeInLeft")
              ##can animate
              that.fadeOut(wasSelected)
              wasSelected.jQdescription.one animate.onAnimatedEnd, ->
                if that.selected != wasSelected
                  # isn't newly selected
                  wasSelected.jQdescription.removeClass("selected")
                  if that.selected and that.selected.jQdescription.hasClass("fadeOutRight")
                    # still selected but description not slided in yet
                    wasSelected = that.selected
                    that.selected.jQdescription.addClass("selected")
                    that.fadeIn(that.selected)
                    wasSelected.jQdescription.one animate.onAnimatedEnd, ->
                      if that.selected == wasSelected and that.selected and that.selected.jQdescription.hasClass("fadeInLeft")
                        #all animations ended, draw line if it still selected
                        that.drawLine()
            else
              t.jQdescription.addClass("selected")
              that.fadeIn(t)
              that.selected = t
              t.jQdescription.one animate.onAnimatedEnd, ->
                if that.selected == t
                  that.selected.jQdescription.addClass("selected")
                  that.drawLine()
        else
          that.clearLine()
          # just select
          that.selectThumbnail(t)
          that.selected = t

          if that.section.find("item.description.selected").length == 0
            t.jQdescription.addClass("selected")
            that.fadeIn(t)
            t.jQdescription.one animate.onAnimatedEnd, ->
              if that.selected == t and that.selected.jQdescription.hasClass("fadeInLeft")
                  that.selected.jQdescription.addClass("selected")
                  that.drawLine()
          else 
            that.section.find("item.description.selected").one animate.onAnimatedEnd, ->
              if that.selected == t
                that.fadeIn(t)
                that.selected.jQdescription.addClass("selected")
                that.selected.jQdescription.one  animate.onAnimatedEnd, ->
                  if that.selected  == t and that.selected.jQdescription.hasClass("fadeInLeft") # if still selected
                    that.drawLine()
        return false

  thumbnailsNotAnimated: ->
    that = @
    @thumbnails.each ->
      t = @ 
      t.jQthumbnail.click ->
        if that.selected
          # there was something selected
          if t == that.selected
            # just deselect
            that.deselectThumbnail(t)
            that.selected = null
            that.clearLine()
          else
            # deselect old one first then select new one
            that.clearLine()
            that.deselectThumbnail(that.selected)
            that.selectThumbnail(t)
            that.selected = t
            that.drawLine()
        else 
          # just select
          that.selectThumbnail(t)
          that.selected = t
          that.drawLine()

  ## check background image
  checkBckgImg: ->
    @thumbnails.each ->
      thumbnail = $(@)
      thumbnailBckgImg = thumbnail.css("background-image")
      thumbnailUrl = thumbnailBckgImg.substring(4, thumbnailBckgImg.length - 1)
      ## Firefox gives url with apostrophes
      if thumbnailUrl.charAt(0) == '"' || thumbnailUrl.charAt(0) == "'" then thumbnailUrl = thumbnailUrl.slice(1, -1)
      $('<img/>').attr('src', thumbnailUrl)
        .load ->
          $(@).remove(); # prevent memory leaks
        .error ->
          $(@).remove(); # prevent memory leaks
          thumbnail.css("background-image", "")
          thumbnail.addClass("logo")


  ## drawing svg

  setThumbnailSize: ->
    @wraps.each ->
      wrap = $(this)
      wrap.height(wrap.width())

    fullSize = @wraps.first().width()
    @thumbnails.each ->
      borderWidth = fullSize * config.thumbnails.borderSize
      if borderWidth < 1 then borderWidth = 1
      @.jQthumbnail.css( {"border-width": borderWidth } )
      @.jQthumbnail.css( { "opacity": 1 } )
    
    height = @wraps.first().height()
    @shortBios.each ->
      $(@).height(height)

  clearLine: ->
    if ! @svg then return # don't try to draw i svg isn't defined
    @svg.find("path").remove()

  drawLine: ->
    if ! @svg then return # don't try to draw i svg isn't defined
    thumbnail = @selected

    title = thumbnail.jQdescription.find(".thumbnail-title")
    thumbnail = thumbnail.jQthumbnail

    startY = thumbnail.offset().top - @section.offset().top + thumbnail.outerHeight()
    startX = thumbnail.offset().left + thumbnail.width() / 2

    #check if line intersects title
    if thumbnail.hasClass("column-first") and title.offset().left <= startX then return
    if thumbnail.hasClass("column-last") and title.offset().left >= startX then return

    #calculate vertical line
    endY = title.offset().top + title.outerHeight() - @section.offset().top
    
    # preserve original values
    originalEndY = endY

    # calculate horizontal leftLine
    if thumbnail.hasClass("column-first")
      endX = title.offset().left + title.width()
    else if thumbnail.hasClass("column-last") 
      endX = title.offset().left
    else
      endY = endY - title.outerHeight()

    if thumbnail.hasClass("column-first") || thumbnail.hasClass("column-last") || thumbnail.hasClass("column-middle") 
      line = @paper.path("M" + startX + " " + startY + "L " + startX + " " + endY + " L " + endX + " " + endY)

    if ! thumbnail.hasClass("column-first") && ! thumbnail.hasClass("column-last")
      #draw disconnected horizontal line
      @paper.path("M " + title.offset().left + " " + originalEndY + "L " + (title.offset().left + title.width()) + " " + originalEndY)



root.Thumbnails = Thumbnails
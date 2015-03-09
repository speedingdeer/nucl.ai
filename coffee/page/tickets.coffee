$ ->
    onresize = () ->
        $(".titlerow.table").each ->
            item = $(this)
            item.height(item.width() / 2)
            item.css("border-radius", item.width() + "px " + item.width() + "px 0 0" )
            item.css("-webkit-border-radius", item.width() + "px " + item.width() + "px 0 0" )
            item.css("-moz-border-radius", item.width() + "px " + item.width() + "px 0 0" )
            item.css("opacity", "1")

    $(window).resize onresize
    onresize()

root = exports ? this # global

defaultOptions = {
  scaleColor: false,
  trackColor: 'rgba(255,255,255,0.3)',
  barColor: '#E7F7F5',
  lineWidth: 8,
  lineCap: 'butt',
  size: 105,
  animate: { duration: 1000, enabled: true }
}

mobileOptions = {
  lineWidth: 4,
  size: 50,
}

$ ->

  getScale = (clock) ->
    if clock.hasClass("days") then return 31
    if clock.hasClass("hours") then return 24
    return 60

  update = (clocks) ->
    for clock in clocks
      percents = clock.find(".value").html() * 100 / getScale(clock)
      clock.data('easyPieChart').update(percents);
      setTimeout ->

  activateTimer = (name) ->
    $("timer-dashboard").each ->
      timer = $(@)
      clocks = []
      options = if timer.parent().parent().hasClass("mobile") then $.extend({}, defaultOptions, mobileOptions) else defaultOptions
      timer.find("clock").each ->
        clocks.push $(@).easyPieChart options

      if timer.attr("name") == name 
        timer.parent().show()
        tCountTo = dateInVienna timer.attr "count-to"
        timer.countdown tCountTo, (event) ->
          if event.type == "finish" && timer.attr("on-finish") && event.finalDate.getHours() == tCountTo.getHours() && event.finalDate.getMinutes() == tCountTo.getMinutes()
            if timer.attr("on-finish") then eval( timer.attr("on-finish") )
          if event.strftime('%S') != timer.find(".seconds").find(".value").html()
            timer.find(".days").find(".value").html event.strftime('%D')
            timer.find(".hours").find(".value").html event.strftime('%H')
            timer.find(".minutes").find(".value").html event.strftime('%M')
            timer.find(".seconds").find(".value").html event.strftime('%S')
            update(clocks)

        if timer.attr("off")
          tOff = dateInVienna timer.attr "off"
          timer.parent().countdown tOff, (event) ->
            if event.type == "finish" && timer.attr("on-off") && event.finalDate.getHours() == tOff.getHours() && event.finalDate.getMinutes() == tOff.getMinutes()
              eval( timer.attr("on-off") )



  activateTimer($("timer-dashboard").first().attr("name") )
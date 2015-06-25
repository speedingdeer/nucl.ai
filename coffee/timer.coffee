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

  timerName = null;

  $("timer-dashboard").each ->
    timer = $(@)
    clocks = []

    if $(".single-timer").length > 0 && timerName != null && timerName != timer.attr("name") 
      # for having multiple timers on one page and switching them automatically
      timer.remove()
      return

    if timer.attr("off") and (new Date(timer.attr("off")) < new Date())
      timer.remove()
      return

    timerName = timer.attr("name")

    options = if timer.parent().parent().hasClass("mobile") then $.extend({}, defaultOptions, mobileOptions) else defaultOptions

    timer.find("clock").each ->
      clocks.push $(@).easyPieChart options

    timer.parent().show()

    timer.countdown timer.attr("count-to"), (event) ->
      if event.type == "finish" && timer.attr("on-finish")
        eval(timer.attr("on-finish"))
      if event.strftime('%S') != timer.find(".seconds").find(".value").html()
        timer.find(".days").find(".value").html event.strftime('%D')
        timer.find(".hours").find(".value").html event.strftime('%H')
        timer.find(".minutes").find(".value").html event.strftime('%M')
        timer.find(".seconds").find(".value").html event.strftime('%S')
        update(clocks)


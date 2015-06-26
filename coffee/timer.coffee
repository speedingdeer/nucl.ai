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

  enableNext = (timers) ->
    selected = null
    selectedCountTo = null
    for timer in timers
      timerOff = new Date(timer.attr("off"))
      countTo = new Date(timer.attr("count-to"))
      if timerOff > new Date()
        if selected == null
          selected = timer
          selectedCountTo = countTo
        else if selectedCountTo > countTo
          selected = timer
          selectedCountTo = countTo

    if selected == null
      return [null, null]

    for timer in timers
      if timer.attr("name") == selected.attr("name")
        timer.parent().show()

    return [selected.attr("name"), new Date(selected.attr("off"))]

  timerName = null
  timerOff = null
  timers = []

  $("timer-dashboard").each ->
    timer = $(@)
    timers.push timer
    clocks = []

    if timers.length == 1
      timerName = timer.attr("name")
      timerOff = new Date(timer.attr("off"))

    options = if timer.parent().parent().hasClass("mobile") then $.extend({}, defaultOptions, mobileOptions) else defaultOptions
    timer.find("clock").each ->
      clocks.push $(@).easyPieChart options
    if timer.attr("name") == timerName then timer.parent().show()
    
    if timer.attr("off")
      timer.parent().countdown timer.attr("off"), (event) ->
        if event.type == "finish" && timer.attr("on-off") then eval( timer.attr("on-off") )



    timer.countdown timer.attr("count-to"), (event) ->
      if event.type == "finish" && timer.attr("on-finish")
        if timer.attr("name") == timerName then timerName = null
        if timer.attr("on-finish") then eval( timer.attr("on-finish") )

      if event.strftime('%S') != timer.find(".seconds").find(".value").html() && timer.attr("name") == timerName
        timer.find(".days").find(".value").html event.strftime('%D')
        timer.find(".hours").find(".value").html event.strftime('%H')
        timer.find(".minutes").find(".value").html event.strftime('%M')
        timer.find(".seconds").find(".value").html event.strftime('%S')
        update(clocks)

      else if timerName == null && timerOff < new Date() && $("timer-dashboard").length == timers.length && $("timer-dashboard").length > 1
        next = enableNext timers
        timerName = next[0]
        timerOff = next[1]



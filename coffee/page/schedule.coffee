root = exports ? this # global

timelineIntervalRange = 15

$ ->
  speakers = $("section.program-schedule p.speakers")
  # pre parse text firt
  speakers.each ->
    if $(@).find(".studio").length > 1
      studios = []
      $(@).find(".studio").each ->
        studios.push $(@)
      for studio, idx in studios
        if idx < studios.length - 1
            if studio.html() == studios[idx+1].html() then studio.remove()

  days = $("section.program-schedule table.talks-list")
  cellMargin = $("div.interval").first().css("margin-top").split("px")[0]

  days.each ->
    day = $(@)
    talks = day.find("div.track")
    talksArray = []
    talks.each ->
      talksArray.push $(@)

    # sort by time and append
    # and remember first start and last end
    talksStartTime = null
    talksFinishTime = null
    talksArray.sort (a,b) ->
      aStartTime = new Date("2001/01/01 " + a.attr("time-start"))
      bStartTime = new Date("2001/01/01 " + b.attr("time-start"))
      aFinishTime = new Date("2001/01/01 " + a.attr("time-finish"))
      bFinishTime = new Date("2001/01/01 " + b.attr("time-finish"))

      if talksStartTime == null || talksStartTime > aStartTime then talksStartTime = aStartTime
      if talksStartTime == null || talksStartTime > bStartTime then talksStartTime = bStartTime

      if talksFinishTime == null || talksFinishTime < aFinishTime then talksFinishTime = aFinishTime
      if talksFinishTime == null || talksFinishTime < bFinishTime then talksFinishTime = bFinishTime

      aStartTime - bStartTime

    #set duration attribute
    for talk in talksArray
      startTime = talk.attr("time-start")
      finishTime = talk.attr("time-finish")
      startDate = new Date("2001/01/01 " + startTime)
      finishDate = new Date("2001/01/01 " + finishTime)
      duration = (finishDate.getHours() * 60 + finishDate.getMinutes()) - (startDate.getHours() * 60 + startDate.getMinutes())
      talk.attr("duration", duration)
      offset = (startDate.getHours() * 60 + startDate.getMinutes()) - (talksStartTime.getHours() * 60 + talksStartTime.getMinutes())
      talk.attr("offset", offset)
      if finishDate.getHours() == talksFinishTime.getHours() && finishDate.getMinutes() == talksFinishTime.getMinutes()
        talk.attr("last", "true")


    if $("section.rooms-schedule").length > 0 
      # append all talks to rooms
      day.find("td.talks-list").remove()
      for talk in talksArray
        room = talk.attr("room")
        day.find("td." + room).append(talk)
        #set up timeline
      talksDuration = (talksFinishTime.getHours() * 60 + talksFinishTime.getMinutes()) - (talksStartTime.getHours() * 60 + talksStartTime.getMinutes())
      intervalsCount = talksDuration / timelineIntervalRange
      for idx in [0...intervalsCount]
        intervalDate = new Date(talksStartTime)
        intervalDate.setMinutes(intervalDate.getMinutes() + idx * timelineIntervalRange)
        minutes = if intervalDate.getMinutes() >= 10 then intervalDate.getMinutes() else "0" + intervalDate.getMinutes() 
        startTime = intervalDate.getHours() + ":" + minutes
        intervalDate.setMinutes(intervalDate.getMinutes() +  timelineIntervalRange)
        minutes = if intervalDate.getMinutes() >= 10 then intervalDate.getMinutes() else "0" + intervalDate.getMinutes() 
        finishTime = intervalDate.getHours() + ":" + minutes
        interval = day.find("td.timeline div.interval.pattern").clone().removeClass("pattern")
        interval.find(".interval-time.start").text(startTime)
        if idx == intervalsCount - 1
          interval.find(".interval-time.finish").text(finishTime)
        day.find("td.timeline").append(interval)


    else
      # simple append and set up timeline duration
      day.find("td.talks-list").html("")
      day.append(talksArray)
    day.removeClass("not-initialized")
    

  if $("section.rooms-schedule").length == 0 then return

  #calculate time / height ratio
  maxHeightDurationRatio = 0
  $("table.talks-list div.track").each ->
    height = $(@).height()
    duration = $(@).attr("duration")
    ratio = height / duration
    if ratio > maxHeightDurationRatio then maxHeightDurationRatio = ratio

  #set up ratio based size
  $("table.talks-list div.track").each ->
    duration = $(@).attr("duration")
    timelineAlignment = ((duration / timelineIntervalRange) - 1 ) * cellMargin
    $(@).height( (duration * maxHeightDurationRatio) + timelineAlignment )
  

  #allign top position
  days.each -> 
    day = $(@)
    #top = $(day.find("div.track[offset=0]")[0]).offset().top
    day.find("div.track").each ->
      track = $(@)
      offset = track.attr("offset")
      positionTop = offset * maxHeightDurationRatio
      margin = ((offset / timelineIntervalRange) + 1 ) * cellMargin
      positionTop = positionTop + margin
      track.css("top", positionTop + "px")

  #set up interval scale
  intervalHeight = timelineIntervalRange * maxHeightDurationRatio
  $("table.talks-list td.timeline div.interval").each ->
    $(@).height(intervalHeight)
  timeLineExtenstion = null 
  $("table.talks-list td.timeline div.interval:last-child").each ->
    if timeLineExtenstion == null then timeLineExtenstion = $(@).find(".finish").height()
    currentHeight = $(@).height()
    $(@).height timeLineExtenstion + currentHeight
  $("div.track[last='true']").each ->
    currentHeight = $(@).height()
    $(@).height currentHeight + timeLineExtenstion


  $("section.program-schedule table").click ->
    button = $(@).find(".button-expand")
    button.toggleClass "expanded"
    name = button.attr "name"
    talksList = $("table.talks-list[name='" + name + "']")
    talksList.removeClass "not-expanded"
    if ! button.hasClass("expanded")
      talksList.addClass "zoomOut"
    else
      talksList.removeClass "zoomOut"
    talksList.one animate.onAnimatedEnd, ->
      if ! button.hasClass("expanded")
        talksList.addClass("not-expanded")

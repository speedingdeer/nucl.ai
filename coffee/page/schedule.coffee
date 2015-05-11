root = exports ? this # global

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

  dCount = 0
  days = $("section.program-schedule table.talks-list")
  days.each ->
    dCount++
    day = $(@)
    talks = day.find("div.track")
    talksArray = []
    talks.each ->
      talksArray.push $(@)

    #set duration attribute
    for talk in talksArray
      startTime = talk.attr("time-start")
      finishTime = talk.attr("time-finish")
      startDate = new Date("2001/01/01 " + startTime)
      finishDate = new Date("2001/01/01 " + finishTime)
      duration = (finishDate.getHours() * 60 + finishDate.getMinutes()) - (startDate.getHours() * 60 + startDate.getMinutes())
      talk.attr("duration", duration)

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


    if $("section.rooms-schedule").length > 0 
      # append all talks to rooms
      day.find("td.talks-list").remove()
      for talk in talksArray
        room = talk.attr("room")
        day.find("td." + room).append(talk)
        #set up timeline
        
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
    $(@).height( duration * maxHeightDurationRatio )

  #set up timeline

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

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

  days = $("section.program-schedule table.talks-list")
  days.each ->
    day = $(@)
    talks = day.find("div.track")
    talksArray = []
    talks.each ->
      talksArray.push $(@)

    #set duration attribute
    for talk in talksArray
      if talk.attr("time-start") != "" && talk.attr("time-finish") != ""
        startTime = talk.attr("time-start")
        finishTime = talk.attr("time-finish")
        startDate = new Date("2001/01/01 " + startTime)
        finishDate = new Date("2001/01/01 " + finishTime)
        duration = (finishDate.getHours() * 60 + finishDate.getMinutes()) - (startDate.getHours() * 60 + startDate.getMinutes())
        talk.attr("duration", duration)

    # sort by time and append
    talksArray.sort (a,b) ->
      aTime = if a.attr("time-start") != "" then a.attr("time-start") else "11:59 pm"
      bTime = if b.attr("time-start") != "" then b.attr("time-start") else "11:59 pm" 
      new Date("2001/01/01 " + aTime) - new Date("2001/01/01 " + bTime) 
    if $("section.rooms-schedule").length > 0 
      # append all talks to rooms
      day.find("td.talks-list").remove()
      for talk in talksArray
        room = talk.attr("room")
        day.find("td." + room).append(talk)
    else
      # simple append
      day.find("td.talks-list").html("")
      day.append(talksArray)

    day.removeClass("not-initialized")

  #calculate time / height ratio
  maxHeightDurationRatio = 0
  $("table.talks-list div.track").each ->
    height = $(@).height()
    duration = $(@).attr("duration")
    ratio = height / duration
    if ratio > maxHeightDurationRatio then maxHeightDurationRatio = ratio


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

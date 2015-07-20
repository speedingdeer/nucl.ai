root = exports ? this # global

$ ->

  if $("sections.page section.stream").length == 0 then return

  # rewrite times - use user timezone
  # root.(dateInVienna)
  $("table.talks-list").each ->
    list = $(@)
    dateStr = list.attr "date"
    list.find(".track").each ->
      track = $(@)
      if track.attr("time-start")
        timeStartStr = track.attr("time-start")
        date = root.dateInVienna(dateStr + timeStartStr)
        hoursStr = if date.getHours() < 10 then "0" + date.getHours().toString() else date.getHours().toString()
        minutesStr = if date.getMinues() < 10 then "0" + date.getMinues().toString() else date.getMinues().toString()
        track.find(".time").html hoursStr + ":" + minutesStr


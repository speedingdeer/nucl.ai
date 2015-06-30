$ ->
  if $("#section-lobby").length == 0 then return

  thisSameDate = (date1, date2) ->
    return date1.getMonth() == date2.getMonth() && date1.getDate() == date2.getDate()

  maxShowingNumber = 3 # number of current / next slots showing

  update = () ->
    date = new Date() # default date
    if url("?date") != null then date = new Date decodeURIComponent url("?date")

    room = "all"
    if url("?room") then room = url("?room")

    $("table").each ->
      dayStr = $(@).attr("date")
      day = new Date dayStr
      if thisSameDate(date, day) 
        #consider this date
        slots = []
        $(@).find("div.track").each ->
          if room == "all" || $(@).attr("room") == "all" || room == $(@).attr("room")
            slots.push $(@)
          else 
            $(@).remove()

        slots.sort (a,b) ->
          a.dateStart = new Date dayStr + " " + a.attr("time-start")
          a.dateEnd = new Date dayStr + " " + a.attr("time-finish")
          b.dateStart = new Date dayStr + " " + b.attr("time-start")
          b.dateEnd = new Date dayStr + " " + b.attr("time-finish")
          a.dateStart - b.dateStart

        toShow = maxShowingNumber

        for slot in slots
          if slot.dateEnd > date && toShow > 0
              slot.show()
              toShow--
              console.log slot
          else 
              slot.hide()
      else
          $(@).hide()

    setTimeout update, 1000

  update()

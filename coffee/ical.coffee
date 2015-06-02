root = exports ? this # global

$ ->
  $("grid.list-schedule").each ->
    days = []
    $(@).find("table.talks-list").each ->
      days.push $(@)

    for day in days
      day.ical = ics()
      dateStr = day.attr("date")
      filename = dateStr.replace("/","-")
      day.find(".track").each ->
        begin = new Date (dateStr + " " + $(@).attr("time-start"))
        end = new Date(dateStr + " " + $(@).attr("time-finish"))


        location = $(@).find("p.title span.room-name").text().trim().replace(/\s+/g, ' ')
        subject = $(@).find("p.title span.title").text().trim().replace(/\s+/g, ' ').replace(/\*/g,'')
        description = $(@).find("p.speakers").text().trim().replace(/\s+/g, ' ')
        if $(@).hasClass "break"
          subject = $(@).text().trim().replace(/\s+/g, ' ')
          description = ""
          location = ""
        if begin.getHours() == 16
          day.ical.addEvent "", "", "", begin.toString(), end.toString()
      # day.ical.download(filename)


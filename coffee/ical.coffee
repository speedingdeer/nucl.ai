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
        speakers = $(@).find("p.speakers").text().trim().replace(/\s+/g, ' ')
        subject =  $(@).find("p.title span.title").text().trim().replace(/\s+/g, ' ')
        if speakers
          subject = subject + " [" + speakers + "]"
        description = window.location.host + $(@).find("p.title a").attr("href")
        if $(@).find("p.title a").hasClass("wip") then description = ""
        if $(@).hasClass "break"
          subject = $(@).text().trim().replace(/\s+/g, ' ')
          description = ""
          location = ""
        day.ical.addEvent subject, description, location, begin, end
      day.ical.download(filename)


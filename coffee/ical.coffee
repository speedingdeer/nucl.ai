root = exports ? this # global

$ ->
  $(".ical-button").each ->
    icalButton = $(@)
    ical = ics()
    source = if icalButton.attr("source") then icalButton.attr("source") else ""
    days = []
    $(".list-schedule " + source + " table.talks-list").each ->
      days.push $(@)
    for day in days
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
        ical.addEvent subject, description, location, begin, end
    icalButton.click ->
      if $("html").hasClass "safari"
        window.alert ("Doesn't supported in Safari")
      else
        ical.download(icalButton.attr("filename"))
      return false


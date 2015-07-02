$ ->
  if $("section.program-schedule").length == 0 then return
  if url("?export") && url("?export") == "csv"
    days = []
    $(".list-schedule " + " table.talks-list").each ->
      days.push $(@)
    schedule = []
    for day, idx in days
      dateStr = day.attr("date")
      day.schedule = []
      day.find(".track").each ->
        begin = dateInVienna(dateStr + " " + $(@).attr("time-start"))
        end = dateInVienna(dateStr + " " + $(@).attr("time-finish"))
        location = $(@).find("p.title span.room-name").text().trim().replace(/\s+/g, ' ')
        speakers = $(@).find("p.speakers").text().trim().replace(/\s+/g, ' ')
        subject =  $(@).find("p.title span.title").text().trim().replace(/\s+/g, ' ')

        if $(@).find("p.title a").hasClass("wip") then description = ""
        if $(@).hasClass "break"
          subject = $(@).text().trim().replace(/\s+/g, ' ')
          description = ""
          location = ""
        slot = {
            "topic": subject,
            "speakers": speakers,
            "room": location,
            "start": begin,
            "finish": end,
            "day": idx + 1
        }
        day.schedule.push slot
        schedule.push slot

    
    
    result = "topic,speakers,room,start,finish,day\r\n"
    for item in schedule
      result += '"' + item.topic + '"' + "," +
        '"' + item.speakers + '"' + "," +
        item.room + "," +
        item.start + "," +
        item.finish + "," +
        item.day + "\r\n"

    blob = new Blob([result], {type: "text/csv;charset=utf-8"})
    saveAs(blob, "schedule.csv");
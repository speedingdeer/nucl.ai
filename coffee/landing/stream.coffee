root = exports ? this # global

$ ->
  section = $("section.stream.landing-stream")
  if section.length == 0 then return

  data = section.find("div.stream-data")
  live = section.find(".announcement.live")
  check = section.find(".announcement.check")

  liveNow = false

  data.find("span.day").each ->
    start = new Date $(@).attr "date-start"
    finish = new Date $(@).attr "date-finish"
    if start <= new Date() <= finish then liveNow = true

  if liveNow 
    live.addClass("block") 
    section.addClass("live")
  else
    check.addClass("block")
    section.addClass("check")

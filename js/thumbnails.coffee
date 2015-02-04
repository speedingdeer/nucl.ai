---
---

root = exports ? this # global


class Thumbnails

  constructor: (section_selector) ->
    @section  = $(section_selector)
    if @section.length != 1 
        console.warn "Can't discover section #{section_selector}"

root.Thumbnails = Thumbnails
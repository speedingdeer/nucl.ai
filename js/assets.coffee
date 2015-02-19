---
---

root = exports ? this # global

$ ->
  root.assets = {
    audienceGif: "{{ '/img/audience.gif' | prepend: site.baseurl }}"
  }

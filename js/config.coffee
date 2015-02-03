---
---

root = exports ? this # global

root.config = {
  header: {
    scrollSpeed: 500
  },
  thumbnails: {
    large: 250 # has to be harcoded, only initial value can be calculated on window.load
  }
}
---
---

# detect ios (ios struggles with our font if used both bold and box-shadow)
if navigator.userAgent.match(/(iPad|iPhone|iPod)/g)
  $("html").appendClass("ios")
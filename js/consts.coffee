---
---

root = exports ? this # global

root.animate = {
  onAnimatedEnd: "webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend",
  onTransitonEnd: "transitionend webkitTransitionEnd oTransitionEnd MSTransitionEnd"
}

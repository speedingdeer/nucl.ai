root = exports ? this # global

root.config = {
  mobile: {
    size: 432,
  },
  header: {
    scrollSpeed: 500
  },
  thumbnails: {
    borderSize: 0.015
  },
  mapOptions: {
    scrollwheel: false,
    zoom: 18,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  }
}

moment.tz.setDefault("Europe/Austria")
$ ->
  initialize = () ->
    mapCanvas = document.getElementById('venue-map-canvas')
    if mapCanvas == null then return
    latLng = new google.maps.LatLng(48.2254061, 16.352991)
    mapOptions = {
      scrollwheel: false,
      center: latLng,
      zoom: 17,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    };
    map = new google.maps.Map(mapCanvas, mapOptions)
    marker = new google.maps.Marker({
      position: latLng,
      map: map,
      title: 'Hello World!'
    });
  google.maps.event.addDomListener(window, 'load', initialize)
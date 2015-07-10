root = exports ? this # global

$ ->

  if $("section.venu").lenght == 0 then return

  initialize = () ->
    mapCanvas = $('#venue-map-canvas')[0]
    if mapCanvas == null then return
    # has this things hardcoded here google geaocoder shows other building at the venue address
    latLng = new google.maps.LatLng(48.217192, 16.353283)
    map = new google.maps.Map( mapCanvas, $.extend(root.config.mapOptions, {center: latLng}) )
    marker = new google.maps.Marker({
      position: latLng,
      map: map,
    })

  google.maps.event.addDomListener(window, 'load', initialize)
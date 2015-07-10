root = exports ? this # global

$ ->

  if $("section.events").lenght == 0 then return

  geocoder = new google.maps.Geocoder()

  build = () ->
      $("div.map.event").each ->
        ev = $(@)
        geocoder.geocode { 'address': ev.attr("location") }, (results, status) ->
          ev.lat = results[0].geometry.location.lat()
          ev.lng = results[0].geometry.location.lng()
          mapCanvas = ev[0]
          console.log ev[0]
          console.log ev
          latLng = new google.maps.LatLng(results[0].geometry.location.lat(), results[0].geometry.location.lng())
          ev.map = new google.maps.Map( mapCanvas, $.extend( root.config.mapOptions, { center: latLng } ) )
          marker = new google.maps.Marker( { position: latLng, map: ev.map } )

  google.maps.event.addDomListener window, 'load', build
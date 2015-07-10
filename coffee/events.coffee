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
          latLng = new google.maps.LatLng results[0].geometry.location.lat(), results[0].geometry.location.lng()
          ev.map = new google.maps.Map( mapCanvas, $.extend( root.config.mapOptions, { center: latLng } ) )

          if ev.attr("placeId")
            service = new google.maps.places.PlacesService(ev.map)
            request = { placeId: ev.attr("placeId") }
            service.getDetails request, (place, status) ->
              if (status == google.maps.places.PlacesServiceStatus.OK)
                marker = new google.maps.Marker { map: ev.map, position: place.geometry.location }
                ev.map.setCenter(place.geometry.location)
          else
            marker = new google.maps.Marker( { position: latLng, map: ev.map } )

  google.maps.event.addDomListener window, 'load', build
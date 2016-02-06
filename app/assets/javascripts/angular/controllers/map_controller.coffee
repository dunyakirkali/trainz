trainzApp.controller 'MapController', ['$rootScope', '$scope', 'DKOverlay', ($rootScope, $scope, DKOverlay) ->
  $scope.focus = (address) ->
    geocoder = new google.maps.Geocoder()
    geocoder.geocode { 'address': address }, (results, status) ->
      if status == google.maps.GeocoderStatus.OK
        bounds = results[0].geometry.bounds
        $scope.draw_map.fitBounds(bounds)
        $rootScope.$emit('resetCompanies')
        $rootScope.$emit('resetTrains')
        $rootScope.$emit('fetchCompanies', bounds)
        $rootScope.$emit('fetchTrains', bounds)
      else
        alert("Could not Geocode: " + status)

  $scope.initDrawMap = () ->
    mapOptions = {
      zoom: 14,
      center: new google.maps.LatLng(43.093336741, -75.194946527),
      mapTypeId: google.maps.MapTypeId.SATELLITE,
      draggable: false,
      zoomControl: true,
      scrollwheel: false,
      disableDoubleClickZoom: true,
      mapTypeControlOptions: {
        mapTypeIds: ['Map', 'Satellite', 'OpenStreetMap']
      }
    }
    $scope.draw_map = new google.maps.Map(d3.select("#google_map").node(), mapOptions)

    # $scope.draw_map.mapTypes.set("OSM", new google.maps.ImageMapType({
    #   getTileUrl: function(coord, zoom) {
    #     // "Wrap" x (logitude) at 180th meridian properly
    #     // NB: Don't touch coord.x because coord param is by reference, and changing its x property breakes something in Google's lib
    #     var tilesPerGlobe = 1 << zoom;
    #     var x = coord.x % tilesPerGlobe;
    #     if (x < 0) {
    #         x = tilesPerGlobe+x;
    #     }
    #     // Wrap y (latitude) in a like manner if you want to enable vertical infinite scroll
    #     return "http://tile.openstreetmap.org/" + zoom + "/" + x + "/" + coord.y + ".png?type=rail";
    #   },
    #   tileSize: new google.maps.Size(256, 256),
    #   name: "OpenStreetMap",
    #   maxZoom: 18
    # }));

    google.maps.Map.prototype.getMapScale = () ->
      circumference = 40075040
      zoom = this.getZoom()
      lat = this.getCenter().lat()
      circumference * Math.cos(lat) / Math.pow(2, zoom + 8)

    $scope.overlay = new DKOverlay($scope.draw_map)
    $scope.overlay.setMap($scope.draw_map)

    google.maps.event.addListener $scope.draw_map, 'idle', () ->
      if !$scope.timer
        $scope.timer = setInterval () ->
          $scope.overlay.redraw()
        , 30

  $rootScope.$on 'countryChanged', (event, country) ->
    $scope.focus(country)

  $scope.initDrawMap()
]

trainzApp.controller 'MapController', ['$rootScope', '$scope', 'DKOverlay', ($rootScope, $scope, DKOverlay) ->
  $scope.drawTrains = (trains) ->
    $.each trains, (way_id, nodes) ->
      flightPlanCoordinates = []
      $.each nodes, (index, node) ->
        flightPlanCoordinates.push { lat: node.lat, lng: node.lon }
      new google.maps.Polyline(
        path: flightPlanCoordinates,
        geodesic: true,
        strokeColor: '#FF0000',
        strokeOpacity: 1.0,
        strokeWeight: 2,
        map: $scope.draw_map
      )

  $scope.focus = (address) ->
    geocoder = new google.maps.Geocoder()
    geocoder.geocode { 'address': address }, (results, status) ->
      if status == google.maps.GeocoderStatus.OK
        bounds = results[0].geometry.bounds
        $scope.draw_map.fitBounds(bounds)
        $rootScope.$emit('resetCompanies')
        $rootScope.$emit('resetTrains')
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

  $rootScope.$on 'trainsChanged', (event, trains) ->
    $scope.drawTrains(trains)

  $rootScope.$on 'trainFetched', (event, train) ->
    $scope.overlay.setTrack(train)
    $scope.drawTrains(train)

  $rootScope.$on 'controlsChanged', (event, controls) ->
    # AudioService.setSpeed($scope.config.controls.speed / 350.)
    $scope.overlay.speed = controls.speed
    $scope.overlay.follow = controls.follow
    # $scope.overlay.setFollowIndex controls.followIndex
  $scope.initDrawMap()
]

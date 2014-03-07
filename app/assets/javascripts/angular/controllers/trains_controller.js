trainzApp.controller('TrainsController', ['$scope', 'D3Service', 'AudioService', 'DKOverlay',
function ($scope, D3Service, AudioService, DKOverlay) {  
  $scope.trains = [{
    name: 'Dunya',
    controls: {
      speed: 0.0001
    }
    // carriages: 
  }];
  
  $scope.horn = function () {
    AudioService.play();
  };
    
  $scope.speedChanged = function() {
    D3Service.setSpeed($scope.trains[0].controls.speed);
  };
  
  console.log(480000 / 256 / Math.pow(13, 2));
  $scope.initDrawMap = function() {
    var sPoint = D3Service.startPoint();
    var mapOptions = { 
      zoom: 14, 
      center: new google.maps.LatLng(sPoint.y, sPoint.x),
      mapTypeControlOptions: {
         mapTypeIds: []
      },
      mapTypeId: google.maps.MapTypeId.SATELLITE,
      draggable: false,
      zoomControl: true,
      scrollwheel: false,
      disableDoubleClickZoom: true
    };
    $scope.draw_map = new google.maps.Map(document.getElementById('google_map'), mapOptions);
    
    google.maps.event.addListener($scope.draw_map, 'idle', function() {
      if(!$scope.overlay) {
        $scope.overlay = new DKOverlay($scope.draw_map.getBounds(), $scope.draw_map);
      }
    });
    
    google.maps.event.addListener($scope.draw_map, 'heading_changed', function() {
      console.log('heading_changed');
      if($scope.overlay) {
        $scope.overlay.draw();
      }
    });
    
    google.maps.event.addListener($scope.draw_map, 'bounds_changed', function() {
      if($scope.overlay) {
        // $scope.overlay.setBounds($scope.draw_map.getBounds());
      }
    });
    

  };
  
  AudioService.init();
  D3Service.init();
  D3Service.animate();
  
  $scope.initDrawMap();
}]);
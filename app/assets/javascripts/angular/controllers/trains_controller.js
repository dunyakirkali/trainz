trainzApp.controller('TrainsController', ['$scope', 'D3Service', 'AudioService',
function ($scope, D3Service, AudioService) {  
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
  
  AudioService.init();
  D3Service.init();
  D3Service.animate();
}]);
trainzApp.controller('TrainsController', ['$scope', 'D3Service', 'AudioService',
function ($scope, D3Service, AudioService) {  
  $scope.trains = [{
    name: 'Dunya',
    controls: {
      speed: 0.0
    }
    // carriages: 
  }];
  
  $scope.horn = function () {
    AudioService.play();
  };
  
  AudioService.init();
  // D3Service.init();
  // D3Service.animate();
}]);
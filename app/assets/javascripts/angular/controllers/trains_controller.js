trainzApp.controller('TrainsController', ['$scope', 'D3Service', 'AudioService',
function ($scope, D3Service, AudioService) {  
  $scope.trains = [{
    name: 'Dunya',
    controls: {
      speed: 0.0
    }
    // carriages: 
  }];
  
  AudioService.init();
  D3Service.init();
  D3Service.animate();
}]);
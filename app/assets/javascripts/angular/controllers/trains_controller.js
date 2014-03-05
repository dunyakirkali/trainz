trainzApp.controller('TrainsController', ['$scope', 'D3Service',
function ($scope, D3Service) {  
  $scope.trains = [{
    name: 'Dunya',
    controls: {
      speed: 0.0
    }
    // carriages: 
  }];
  
  D3Service.init();
  D3Service.animate();
}]);
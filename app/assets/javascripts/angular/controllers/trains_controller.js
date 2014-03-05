trainzApp.controller('TrainsController', function ($scope) {
  $scope.phones = [
    {'name': 'Nexus S',
     'snippet': 'Fast just got faster with Nexus S.'},
    {'name': 'Motorola XOOM™ with Wi-Fi',
     'snippet': 'The Next, Next Generation tablet.'},
    {'name': 'MOTOROLA XOOM™',
     'snippet': 'The Next, Next Generation tablet.'}
  ];
  
  $scope.trains = [{
    name: 'Dunya',
    controls: {
      speed: 0.0
    }
    // carriages: 
  }];
});
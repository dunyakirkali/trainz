trainzApp.service('AudioService', function () {
  var audioService = {};
  
  audioService.play = function() {
    var thissound = $("#yourAudioTag");
    thissound.currentTime = 0.0;
    thissound.play();
  }
  
  audioService.init = function() {
    $("#yourAudioTag").bind('ended', function(){
      this.horned = false;
    });  
  }
    
  return audioService;
});
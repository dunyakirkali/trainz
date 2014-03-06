trainzApp.service('AudioService', function () {
  this.el;
  
  this.play = function() {
    this.el.currentTime = 0.0;
    this.el.play();
  }
  
  this.init = function() {
    this.el = document.getElementById("yourAudioTag");
    $("#yourAudioTag").bind('ended', function(){
      this.horned = false;
    });  
  }
  
  return this;
});
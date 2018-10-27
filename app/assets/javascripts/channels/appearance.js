App.appearance = App.cable.subscriptions.create({
  channel:'AppearanceChannel'
 }, {
  received: function(data) {
    var user = JSON.parse(data)
    if (user.online === true){
      $(userImgIdConstructor(user)).attr('class', 'online fa fa-circle');
    };
    if (user.online === false){
      $(userImgIdConstructor(user)).attr('class', 'offline fa fa-circle');
    };
  }
});

var userImgIdConstructor = function(user){
  return "#" + user.id + "-status";
}
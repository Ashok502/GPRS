App.appearance = App.cable.subscriptions.create({
  channel:'AppearanceChannel'
 }, {
  received: function(data) {
    var user = JSON.parse(data)
    if (user.online === true){
      $(userStatusConstructor(user)).attr('class', 'online');
      $(userChatConstructor(user)).attr('class', 'online');
    };
    if (user.online === false){
      $(userStatusConstructor(user)).attr('class', 'offline');
      $(userChatConstructor(user)).attr('class', 'offline');
    };
  }
});

var userStatusConstructor = function(user){
  return "#" + user.id + "-status";
}

var userChatConstructor = function(user){
  return "#" + user.id + "-chat-status";
}
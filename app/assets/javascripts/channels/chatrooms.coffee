App.chatrooms = App.cable.subscriptions.create "ChatroomsChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    active_chatroom = $("[data-behavior='chat_messages'][data-chatroom-id='#{data.chatroom_id}']")
    current_user_id = data.current_user_id
    user_id = data.user_id
    active_class = (data.current_user_id == data.user_id)
    pbclass = (active_class == false) ? 'pull-right' : 'pull-left'
    pdclass = (active_class == false) ? 'pull-left' : 'pull-right'
    if active_chatroom.length > 0

      if document.hidden
        if $(".strike").length == 0
          active_chatroom.append("<div class='strike'><span>Unread Messages</span></div>")

      else
        App.last_read.update(data.chatroom_id)

      # Insert the message
      active_chatroom.append("<ul class='chat'>
      <li><div class='row'>
        <div class='#{pclass}'><strong>#{data.username} : </strong>#{data.body}</div>
        <div class='#{pdclass}'>#{data.date}</div></div></li></ul>")

    else
      $("[data-behavior='chatroom-link'][data-chatroom-id='#{data.chatroom_id}']").css("font-weight", "bold")

  send_message: (chatroom_id, message) ->
    @perform "send_message", {chatroom_id: chatroom_id, body: message}


class MessageRelayJob < ApplicationJob
	queue_as :default

	def perform(message)
		ActionCable.server.broadcast "chatrooms:#{message.chatroom.id}", {
			username: message.user.username,
			body: message.body,
			chatroom_id: message.chatroom.id,
			date: message.created_at.strftime("%d %b. %Y"),
			current_user_id: message.chatroom.user_id,
			user_id: message.user_id
		}
	end
end

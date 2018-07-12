class AppearanceChannel < ApplicationCable::Channel
	def subscribed
		member = User.where(id: current_user.id).first
		return unless member
		member.is_online
		stream_from "appearance_channel"
	end

	def unsubscribed
		member = User.where(id: current_user.id).first
		return unless member
		member.is_offline
	end
end

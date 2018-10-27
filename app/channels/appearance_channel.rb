class AppearanceChannel < ApplicationCable::Channel
  def subscribed
    member = User.where(id: current_user.id).first
    return unless member
    member.update_attributes(online: true)
    stream_from "appearance_user"
  end

  def unsubscribed
    member = User.where(id: current_user.id).first
    return unless member
    member.update_attributes(online: false)
  end
end

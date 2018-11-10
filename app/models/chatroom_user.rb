class ChatroomUser < ApplicationRecord
  belongs_to :chatroom
  belongs_to :user

  before_create :set_last_read
  after_create_commit { notify }

  def set_last_read
    self.last_read_at = Time.zone.now
  end


  private

  def notify
    Notification.create(user_id: self.chatroom.user_id, chatroom_id: self.chatroom.id, event: "#{self.user.username} Joined your #{self.chatroom.name}")
  end
end

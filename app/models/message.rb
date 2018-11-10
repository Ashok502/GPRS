class Message < ApplicationRecord
  belongs_to :user
  belongs_to :conversation
  after_create_commit { MessageBroadcastJob.perform_later(self) }
  after_create_commit { notify }

  private

  def notify
    Notification.create(event: "New Message #{self.body}")
  end
end

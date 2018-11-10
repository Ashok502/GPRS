class AddUserIdToNotification < ActiveRecord::Migration[5.2]
  def change
  	add_column :notifications, :user_id, :integer
  	add_column :notifications, :chatroom_id, :integer
  end
end

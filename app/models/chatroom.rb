class Chatroom < ApplicationRecord
  has_many :chatroom_users, dependent: :destroy
  has_many :users, through: :chatroom_users
  has_many :chat_messages, dependent: :destroy
  validates :name, uniqueness: true, presence: true
end

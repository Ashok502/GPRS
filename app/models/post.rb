class Post < ApplicationRecord
	belongs_to :user
	validates :body, presence: true
	has_many :notifications, dependent: :destroy
end

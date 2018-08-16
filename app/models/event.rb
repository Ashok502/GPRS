class Event < ApplicationRecord
  belongs_to :user
  validates :start_date, :end_date, :title, presence: true
end

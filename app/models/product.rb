class Product < ApplicationRecord
	belongs_to :user
	belongs_to :category
	has_many :logos, as: :logable
	accepts_nested_attributes_for :logos, :allow_destroy => true, :reject_if => :all_blank
	validates :title, :category_id, :size, :price, :quantity, presence: true	
end

class Product < ApplicationRecord
	belongs_to :user
	belongs_to :category
	has_many :logos, as: :logable
	has_many :reviews, dependent: :destroy
	accepts_nested_attributes_for :logos, :allow_destroy => true, :reject_if => :all_blank
	validates :title, :category_id, :size, :price, :quantity, presence: true	

	def average_rating
		self.reviews.present? ? (self.reviews.sum{|a| a.rating} / reviews_count) : 0
	end

	def reviews_count
		self.reviews.count
	end
end

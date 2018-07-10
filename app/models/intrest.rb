class Intrest < ApplicationRecord
	belongs_to :user
	validates :name, uniqueness: true, presence: true

	# def name_exist(inuser, inname)
	# 	self.user_id == inuser && self.name != inname
	# end
end

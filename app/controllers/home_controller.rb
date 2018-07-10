class HomeController < ApplicationController
	def index
		@posts = Post.all 
		@post = Post.new
		@intrest = Intrest.new
		@ad = Ad.new
		@messages = Message.order(created_at: :asc)
		@notifications = current_user ? current_user.notifications.count : 0
		@intrests = current_user ? current_user.intrests.all : 0
		@ads = current_user ? current_user.ads.all : 0
	end
end

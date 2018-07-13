class HomeController < ApplicationController
	def index
		@posts = Post.page(params[:page]).per_page(3)
		@post = Post.new
		@intrest = Intrest.new
		@ad = Ad.new
		session[:conversations] ||= []
		@notifications = current_user ? current_user.received_requests.where("accept = 1") : 0
		@intrests = current_user ? current_user.intrests.all : 0
		@ads = current_user ? current_user.ads.all : 0
		@users = User.all.where.not(online: false, id: current_user)
		@conversations = Conversation.includes(:recipient, :messages).find(session[:conversations])
	end
end

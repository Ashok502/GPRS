class HomeController < ApplicationController
	def index
		@posts = Post.page(params[:page]).per_page(3)
		@post = Post.new
		@intrest = Intrest.new
		@comment = Comment.new
		@ad = Ad.new
		@gallery = Gallery.new
		@galleries = current_user ? current_user.galleries : 0
		session[:conversations] ||= []
		@intrests = current_user ? current_user.intrests.all : 0
		@ads = current_user ? current_user.ads.all : 0
		@users = User.where.not(id: current_user).order("updated_at desc")
		@conversations = Conversation.includes(:recipient, :messages).find(session[:conversations])
	end
end

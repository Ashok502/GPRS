class ApplicationController < ActionController::Base
  layout :layout?
  include ApplicationHelper
  helper :all
  before_action :user_status?, if: proc { user_signed_in? }
  before_action :all_actions, if: proc { user_signed_in? }

  def is_login?
    unless current_user
      flash[:warning] = "Please login to continue"
      redirect_to "/"
    end
  end


  def layout?
  	unless current_user
  		"login"
  	else
  		"application"
  	end
  end

  def all_actions
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

  private
  def user_status?
    current_user.update_attribute(:updated_at, Time.current)
  end
end

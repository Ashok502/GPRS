class ApplicationController < ActionController::Base
  layout :layout?
  include ApplicationHelper
  helper :all
  helper_method :current_cart
  before_action :user_status?, if: proc { user_signed_in? }
  before_action :all_actions, if: proc { user_signed_in? }

  def is_login?
    unless current_user
      session[:ss] = request.fullpath
      flash[:warning] = "Please login to continue"
      redirect_to "/login"
    end
  end

  def after_sign_in_path_for(resource_or_scope)
    if resource_or_scope.is_a?(User)
      session[:ss].present? ? session[:ss] : (current_user && current_user.role == 'admin' ? "/dashboards" : root_path)
    end
  end

  def layout?
    current_user && current_user.role == 'admin' ? 'admin' : (current_user ? 'application' : 'login')
  end

  def current_cart(cart_exist=false)
    cart = Cart.find(session[:cart]) if session[:cart]
    unless cart
      if cart_exist
        cart = Cart.create
      else
        cart = Cart.new
      end
    end
    cart
  end

  def all_actions
    @post = Post.new
    @intrest = Intrest.new
    @comment = Comment.new
    @ad = Ad.new
    @gallery = Gallery.new
    session[:conversations] ||= []
    @posts = Post.order("created_at desc").page(params[:page]).per_page(3)    
    @galleries = current_user ? current_user.galleries : 0
    @intrests = current_user ? current_user.intrests.all : 0
    @ads = current_user ? current_user.ads.order("created_at desc") : 0
    @users = User.where.not(id: current_user, role: 'admin').order("updated_at desc")
    @orders = current_user.orders.where(success: true).page(params[:order_page]).per_page(5)
    @conversations = Conversation.includes(:recipient, :messages).find(session[:conversations])
  end

  private
  def user_status?
    current_user.update_attribute(:updated_at, Time.current)
  end
end

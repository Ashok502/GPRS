class ApplicationController < ActionController::Base
  layout :layout?
  include ApplicationHelper
  helper :all
  before_action :user_status?, if: proc { user_signed_in? }

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

  private
  def user_status?
    current_user.update_attribute(:updated_at, Time.current)
  end
end

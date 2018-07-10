class ApplicationController < ActionController::Base
  layout :layout?
  include ApplicationHelper
  helper :all

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
end

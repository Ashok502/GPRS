class OmniauthsController < Devise::OmniauthCallbacksController

	def facebook
		@user = User.from_omniauth(request.env["omniauth.auth"])
		puts @user.errors.to_a
		if @user.persisted?
      sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
    else
    	session["devise.facebook_data"] = request.env["omniauth.auth"]
    	redirect_to root_path
    end
  end

  def twitter
    @user = User.from_omniauth(request.env["omniauth.auth"])
    puts @user.errors.to_a
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, kind: "Twitter") if is_navigational_format?
    else
      session["devise.twitter_data"] = request.env["omniauth.auth"]
      redirect_to root_path
    end
  end
end

class ProfilesController < ApplicationController
	def update
		@user = current_user
		@user.errors.add(:password, "Is required") if user_params.nil? or params[:user][:password].to_s.blank?
		if @user.errors.empty? and @user.update_with_password(user_params)
			sign_in(:user, @user, bypass: true)
			ajax_submit?
		end
	end

	def update_profile
		@user = current_user
		if @user.update_attributes(user_params)
			ajax_submit?
		end
	end

	private

	def user_params
		params.require(:user).permit!
	end
end

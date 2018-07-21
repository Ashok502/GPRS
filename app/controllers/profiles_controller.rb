class ProfilesController < ApplicationController

	def index
		search = params[:search]
		@users = User.search(search, current_user.id)
	end	

	def update
		@user = current_user
		@user.errors.add(:password, "Is required") if user_params.nil? or params[:user][:password].to_s.blank?
		if @user.errors.empty? and @user.update_with_password(user_params)
			sign_in(:user, @user, bypass: true)
			ajax_submit?
		end
	end

	def sent
		@user = current_user
		puts @user.id
		@receiver = User.find(params[:id])
		puts @receiver.id
		@sent_friend = Friend.find_by_sender_id_and_receiver_id(@user.id, @receiver.id)
		@received_friend = Friend.find_by_sender_id_and_receiver_id(@receiver.id, @user.id)
		if !(@sent_friend || @received_friend)
			Friend.create(sender_id: @user.id, receiver_id: @receiver.id)
		end
		ajax_submit?
	end

	def update_profile
		@user = current_user
		if @user.update_attributes(user_params)
			ajax_submit?
		end
	end

	def accept
		@friend = Friend.find(params[:id])
		@notification = params[:message]
		@notifications = current_user ? current_user.received_requests.where(accept: 1) : 0
		@friend.update(accept: params[:accept])
		ajax_submit?
	end

	private

	def user_params
		params.require(:user).permit!
	end
end

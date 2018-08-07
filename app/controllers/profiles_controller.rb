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
		@receiver = User.find(params[:id])
		@sent_friend = Friend.find_by_sender_id_and_receiver_id(current_user.id, @receiver.id)
		if !@sent_friend.present?
			Friend.create(sender_id: current_user.id, receiver_id: @receiver.id)
		else
			@sent_friend.update(accept: @sent_friend.accept == 0 ? 1 : 0)
		end
		ajax_submit?
		@sents = @receiver.sent_requests.where(accept: 1).count
		@receives = @receiver.received_requests.where(accept: 1).count
	end

	def update_profile
		@user = current_user
		if @user.update_attributes(user_params)
			ajax_submit?
		end
	end

	def show
		@user = User.find(params[:id])
		@sents = @user.sent_requests.where(accept: 1).count
		@receives = @user.received_requests.where(accept: 1).count
		ajax_submit?
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

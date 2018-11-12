class ChatroomsController < ApplicationController
    before_action :is_login?
	def index
		@chatrooms = Chatroom.all
		@chatroom = Chatroom.new
	end

	def create
		@chatroom = Chatroom.new(new_params.merge(user_id: current_user.id))
		@chatrooms = Chatroom.all
		if @chatroom.save
			ajax_submit?
		end
	end

	def show
		@chatroom = Chatroom.find(params[:id])
		@chatroom.chatroom_users.where(user_id: current_user.id).first_or_create
		@messages = @chatroom.chat_messages.order(created_at: :desc).limit(100).reverse
		@chatroom_user = current_user.chatroom_users.find_by(chatroom_id: @chatroom.id)
		@chatroom_users = @chatroom.chatroom_users.where.not(user_id: current_user)
		@message = @chatroom.chat_messages.new
	end

	def edit
		@chatroom = Chatroom.find(params[:id])
		@chatrooms = Chatroom.all
		@chatroom_user = @chatroom.chatroom_users.where(user_id: current_user.id).destroy_all
		ajax_submit?
	end

	def destroy
		@chatroom = Chatroom.find(params[:id])
		@chatroom.destroy
		ajax_submit?
	end

	private

	def new_params
		params.require(:chatroom).permit!
	end
end

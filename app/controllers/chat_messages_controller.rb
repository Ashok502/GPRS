class ChatMessagesController < ApplicationController
	before_action :authenticate_user!
  before_action :set_chatroom

  def create
    message = @chatroom.chat_messages.new(message_params)
    message.user = current_user
    message.save
    MessageRelayJob.perform_later(message)
  end

  private

    def set_chatroom
      @chatroom = Chatroom.find(params[:chatroom_id])
    end

    def message_params
      params.require(:chat_message).permit!
    end
end

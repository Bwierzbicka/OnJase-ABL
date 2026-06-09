class MessagesController < ApplicationController
  def create
    @chat = current_user.chats.find(params[:chat_id])

    @message = Message.new(message_params)
    @message.chat = @chat
    @message.role = "user"
    @message.save
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end

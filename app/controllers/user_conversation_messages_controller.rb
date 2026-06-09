class UserConversationMessagesController < ApplicationController
  def create
    @user_conversation_message = UserConversation.new(user_conversation_message_params)
    @user_conversation_message.message = current_user
    @user_conversation_message.save
  end

  private

  def user_conversation_message_params
    params.require(:user_conversation_message).permit(:content, :translation)
  end
end

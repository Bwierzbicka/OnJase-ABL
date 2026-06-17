class UserConversationMessagesController < ApplicationController
  def create
    @user_conversation = current_user.user_conversations.find(params[:user_conversation_id])
    @message = UserConversationMessage.new(user_conversation_message_params)
    @message.user_conversation = @user_conversation
    @message.user_id = current_user.id

    if @message.save!
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to user_conversation_path(@user_conversation) }
      end
    else
      render "user_conversation/show", status: :unprocessable_entity
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("new_message_container", partial: "user_conversation_messages/user_conversation_form",
                                                                             locals: { user_conversation: @user_conversation, user_conversation_message: @user2_conversation_message })
        end
        format.html { render "user_conversation/show", status: :unprocessable_entity }
      end
    end
  end

  private

  def user_conversation_message_params
    params.require(:user_conversation_message).permit(:content)
  end
end

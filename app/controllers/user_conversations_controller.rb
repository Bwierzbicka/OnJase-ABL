class UserConversationsController < ApplicationController
  def new
    @user_conversation = UserConversation.new
  end

  def index
    @user_conversations = current_user.user_conversations
  end

  def create
    @user_conversation = UserConversation.new
    @user_conversation.user1 = current_user
    @user_conversation.user2 = User.find(user_conversation_params[:user_id_2])

    if @user_conversation.save!
      redirect_to user_conversation_path(@user_conversation)
    else
      render "new_user_conversation", status: :unprocessable_entity
    end
  end

  def show
    @user_conversation = UserConversation.find(params[:id])
    @user_conversation_message = UserConversationMessage.new
    @current_user_id = current_user.id ## probably dont need it anymore
  end

  def destroy
    @user_conversation = UserConversation.find(params[:id])
    @user_conversation.destroy
  end

  def call_assistant
    @user_conversation = UserConversation.find(params[:id])
    ConversationAssistantJob.perform_later(@user_conversation.id, current_user)
    head :ok
  end

  private

  def user_conversation_params
    params.require(:user_conversation).permit(:user_id_2)
  end
end

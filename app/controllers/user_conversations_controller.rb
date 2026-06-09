class UserConversationsController < ApplicationController
  def new
    @user_conversation = UserConversation.new
  end

  def create
    @user_conversation = UserConversation.new(user_conversation_params)
    @user_conversation.user = current_user
    @user_conversation.save
  end

  def show
    @user_conversation = Userconversation.find(params[:id])
  end

  def destroy
    @user_conversation = Userconversation.find(params[:id])
    @user_conversation.destroy
  end

  private

  def user_conversation_params
    params.require(:user_conversation).permit(:user_id_1, :user_id_2)
  end
end

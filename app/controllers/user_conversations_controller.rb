class UserConversationsController < ApplicationController
  def new
    @userconversation = UserConversation.new
  end

  def create
    @userconversation = UserConversation.new(userconversation_params)
    @userconversation.user = current_user
    @userconversation.save
  end

  def show
    @userconversation = Userconversation.find(params[:id])
  end

  def destroy
    @userconversation = Userconversation.find(params[:id])
    @userconversation.destroy
  end

  private

  def userconversation_params
    params.require(:userconversation).permit(:user_id_1, :user_id_2)
  end
end

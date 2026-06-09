class UserConversationMessagesController < ApplicationController
  def create
    @userconversationmessage = UserConversation.new(userconversationmessage_params)
    @userconversationmessage.message = current_user
    @userconversationmessage.save
  end

  private

  def userconversationmessage_params
    params.require(:userconversationmessage).permit(:content, :translation)
  end
end

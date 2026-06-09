class ChatsController < ApplicationController
  def index
    @chats = current_user.chats
  end

  def new
    @chat = Chat.new
  end

  def create
    @chat = Chat.new(title: Chat::DEFAULT_TITLE)
    @chat.user = current_user

    @chat.save
    redirect_to chat_path(@chat)
  end

  def show
    @chat = Chat.find(params[:id])
    @message = Message.new
  end
end

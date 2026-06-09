class ChatsController < ApplicationController
  def index
    @chats = current_user.chats
  end

  def new
    @chat = Chat.new
  end

  def create
    @chat = Chat.new
    @chat.user = current_user

    @chat.save
  end

  def show
    @chat = Chat.find(params[:id])
  end
end

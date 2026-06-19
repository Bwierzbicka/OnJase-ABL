class ChatsController < ApplicationController
  def index
    @chats = current_user.chats
                         .includes(:messages)
                         .sort_by { |c| c.messages.map(&:created_at).max || Time.at(0) }
                         .reverse
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
    @chat = current_user.chats.find(params[:id])
    @message = Message.new
  end

  def destroy
    @chat = current_user.chats.find(params[:id])
    @chat.destroy

    redirect_to chats_path
  end
end

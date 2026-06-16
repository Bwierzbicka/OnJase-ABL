class UserConversationsController < ApplicationController
  def new
    @user_conversation = UserConversation.new
    #  authorize @user_conversation
  end

  def index
    @user_conversations = current_user.user_conversations
  end

  def create
    @user_conversation = UserConversation.new
    #  authorize @user_conversation
    @user_conversation.user1 = current_user

    user2 = User.find_by(username: user_conversation_params[:username])

    if user2.nil?
      @user_conversation.errors.add(:username, "not found")
      render :new, status: :unprocessable_entity
      return
    end

    existing = UserConversation.where(user_id_1: current_user.id, user_id_2: user2.id)
                               .or(UserConversation.where(user_id_1: user2.id, user_id_2: current_user.id))
    if existing.exists?
      @user_conversation.errors.add(:username, "already has an existing conversation with you")
      render :new, status: :unprocessable_entity
      return
    end

    @user_conversation.user2 = user2

    if @user_conversation.save
      redirect_to user_conversation_path(@user_conversation)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @user_conversation = UserConversation.find(params[:id])
    authorize @user_conversation
    @user_conversation_message = UserConversationMessage.new
    @other_user = @user_conversation.other_participant(current_user)
  end

  def destroy
    @user_conversation = UserConversation.find(params[:id])
    authorize @user_conversation
    @user_conversation.destroy
  end

  def call_assistant
    @user_conversation = UserConversation.find(params[:id])
    authorize @user_conversation
    ConversationAssistantJob.perform_later(@user_conversation, current_user)
    head :ok
  end

  def call_typing_assistant
    @user_conversation = UserConversation.find(params[:id])
    authorize @user_conversation
    ConversationTypingAssistantJob.perform_later(@user_conversation, current_user, params[:message_text].to_s)
    head :ok
  end

  def save_item_to_saveable_items
    SaveItemFromMessagesJob.perform_later(current_user, params[:item].to_s)
    head :ok
  end

  def retrieve_users
    # get the query thats being sent (params)
    puts params
  end

  private

  def user_conversation_params
    params.require(:user_conversation).permit(:username)
  end
end

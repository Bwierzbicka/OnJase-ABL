class MessagesController < ApplicationController
  def create
    @chat = current_user.chats.find(params[:chat_id])
    @message = Message.new(message_params)
    @message.chat = @chat
    @message.role = "user"

    if @message.save
      CreateChatAssistantMessageJob.perform_later(@chat, current_user)

      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.append("messages", partial: "messages/message", locals: { message: @message }),
            turbo_stream.update("new_message_container", partial: "messages/form",
                                                         locals: { chat: @chat, message: @chat.messages.build })
          ]
        end
        format.html { redirect_to chat_path(@chat) }
      end
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("new_message_container", partial: "messages/form",
                                                                             locals: { chat: @chat, message: @message })
        end
        format.html { render "chats/show", status: :unprocessable_entity }
      end
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end

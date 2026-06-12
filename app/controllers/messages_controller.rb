class MessagesController < ApplicationController
  def create
    @chat = current_user.chats.find(params[:chat_id])
    @message = Message.new(message_params)
    @message.chat = @chat
    @message.role = "user"

    if @message.valid?
      @assistant_message = @chat.messages.create(role: "assistant", content: "")
      @chat.with_instructions(instructions).ask(@message.content)
      @chat.generate_title_from_first_message
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to chat_path(@chat) }
      end
    else
      render "chats/show", status: :unprocessable_entity
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

  def instructions
    "You are a warm, enthusiastic Québécois French tutor from Montréal.
    - Use authentic québécois expressions (joual, sacres if appropriate to context)
    - Contrast québécois usage with standard French where helpful
    - Reference local culture (hockey, poutine, dépanneur, etc.)
    - Correct learners gently using québécois phrasing"
  end
end

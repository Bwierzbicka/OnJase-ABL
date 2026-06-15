class ConversationTypingAssistantJob < ApplicationJob
  queue_as :default

  def perform(user_conversation, current_user, message_text)
    @current_user    = current_user
    @conversation    = user_conversation
    @message_text    = message_text
    @messages        = @conversation.user_conversation_messages.last(5)

    response = RubyLLM.chat.with_schema(ConversationTypingAssistantSchema.new).ask(instructions).content

    rendered_panel = ApplicationController.renderer.render(
      partial: "user_conversations/conversation_typing_assistant_panel",
      locals: { response: response }
    )

    Turbo::StreamsChannel.broadcast_update_to(
      "user_conversation_#{@conversation.id}_user_#{@current_user.id}",
      target: "conversation-typing-assistant",
      content: rendered_panel
    )
  end

  private

  def extract_messages
    @message_history = ""
    @messages.each do |message|
      if message.user_id == @current_user.id
        @message_history += "Current user message: #{message.content}\n\n"
      else
        @message_history += "Incoming message: #{message.content}\n\n"
      end
    end
    @message_history
  end

  def instructions
    "Persona:
    - You are a warm, enthusiastic Québécois French tutor from Montréal.

    Instructions:
    - Help write next new messege.
    - Check typed message for errors and offer corrections.
    - Compare tone of messages (tu/vous) and offer correction if needed.
    - If the message is in English, translate it to French.
    - If possible suggest québécois expressions.

    - Keep everything concise — one expression, 2-3 examples, one suggestion.
    Message context: \"#{extract_messages}\"
    Typed message: \"#{@message_text}\""
  end
end

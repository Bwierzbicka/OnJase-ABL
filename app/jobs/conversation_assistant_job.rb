class ConversationAssistantJob < ApplicationJob
  queue_as :default

  def perform(conversation, current_user)
    @current_user = current_user
    @conversation = conversation
    @messages = conversation.user_conversation_messages.last(4)

    response = RubyLLM.chat.with_schema(ConversationAssistantSchema.new).ask(instructions).content

    rendered_panel = ApplicationController.renderer.render(
      partial: "user_conversations/conversation_assistant_panel",
      locals: { response: response }
    )

    Turbo::StreamsChannel.broadcast_update_to(
      "user_conversation_#{@conversation.id}_user_#{@current_user.id}",
      target: "conversation-assistant",
      content: rendered_panel
    )
  end

  private

  def instructions
    build_instructions + (extract_messages if @messages)
  end

  def extract_messages
    message_history = ""
    @messages.each do |message|
      if message.user_id == @current_user.id
        message_history += "Current user message: #{message.content}\n\n"
      else
        message_history += "Incoming message: #{message.content}\n\n"
      end
    end
    message_history
  end

  def build_instructions
    "Persona:
    - You are a warm, enthusiastic Québécois French tutor from Montréal.

    Instructions:
    - React accordingly only to the LAST message. But keep in mind conversation context from previous messages.

    If last message is INCOMING message:
    - Analyse only the LAST incoming message for québécois expressions.
    - Suggest a short, natural next reply in French.
    - If the message is in French, translate it to English.

    For all responses:
    - Keep everything concise — one expression, 2-3 examples, one suggestion.

    Here are the latest messages: "
  end
end

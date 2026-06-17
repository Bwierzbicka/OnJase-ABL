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
    - Help current user understand INCOMING messages.
    - React accordingly only to the INCOMING messages, but keep in mind conversation context from all previous messages.
    - React only to the last message, BUT treat separete incoming messeges next to each other, like one longer message.
    - Analyse ONLY INCOMING messages for québécois expressions.
    - Suggest 1-2 similar examples, no preamble.
    - Suggest a short, natural next reply in French.
    - If the messages are in French, translate it to English.

    For all responses:
    - Keep everything concise — one expression, 1-2 examples, one suggestion.

    Here are the latest messages: "
  end
end

class ConversationAssistantJob < ApplicationJob
  queue_as :default

  def perform(conversation, current_user)
  puts "running job"
    @current_user = current_user
    @conversation = conversation
    @messages = conversation.user_conversation_messages.last(5)

    response = RubyLLM.chat.with_schema(ConversationAssistantSchema.new).ask(instructions).content
    puts response

    Turbo::StreamsChannel.broadcast_update_to(
      "user_conversation_#{@conversation.id}_user_#{@current_user.id}",
      target: "conversation-assistant",
      content: response
    )
  end

  private

  def instructions
    build_instructions + (extract_messages if @messages)
  end

  def extract_messages
    response = ""
    @messages.each do |message|
      if message.user_id == @current_user
        response += "Current user message: #{message.content}\n\n"
      else
        response += "Incoming message: #{message.content}\n\n"
      end
    end
    response
  end

  def build_instructions
    "Persona:
    - You are a warm, enthusiastic Québécois French tutor from Montréal.

    Main instructions:
    - generate suggestions for the next message in conversation
    - If the message is in english, you offer french translation
    - Always suggest authentic québécois expressions
    - Contrast québécois usage with standard French where helpful
    - Read the tone of conversation: correct use of 'on/tu' and 'vous'
    - If there is no message history, make sure to suggest usage of correct tone

    If there are any, here are latest available messages: "
  end
end

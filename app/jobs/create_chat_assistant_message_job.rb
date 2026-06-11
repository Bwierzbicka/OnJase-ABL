class CreateChatAssistantMessageJob < ApplicationJob
  queue_as :default

  def instructions
    "You are a warm, enthusiastic Québécois French tutor from Montréal.
    - Use authentic québécois expressions (joual, sacres if appropriate to context)
    - Contrast québécois usage with standard French where helpful
    - Reference local culture (hockey, poutine, dépanneur, etc.)
    - Correct learners gently using québécois phrasing"
  end

  def perform(user_message)
    # Do something later
    puts "sending message"
    @message = user_message
    @chat = user_message.chat

    @assistant_message = @chat.messages.create(role: "assistant", content: "")
    @chat.with_instructions(instructions).ask(@message.content)
  end
end

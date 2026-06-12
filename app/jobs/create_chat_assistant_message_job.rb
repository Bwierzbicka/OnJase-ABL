class CreateChatAssistantMessageJob < ApplicationJob
  include ActionView::RecordIdentifier

  queue_as :default

  def instructions
    "You are a warm, enthusiastic Québécois French tutor from Montréal.
    - Use authentic québécois expressions (joual, sacres if appropriate to context)
    - Contrast québécois usage with standard French where helpful
    - Reference local culture (hockey, poutine, dépanneur, etc.)
    - Correct learners gently using québécois phrasing"
  end

  # def perform(user_message)
  #   # Do something later
  #   puts "sending message"
  #   @message = user_message
  #   @chat = user_message.chat

  #   @assistant_message = @chat.messages.create(role: "assistant", content: "")
  #   @chat.with_instructions(instructions).ask(@message.content)
  #   @chat.generate_title_from_first_message

  #   return unless @chat.title_previously_changed?

  #   Turbo::StreamsChannel.broadcast_update_to(@chat, target: "chat_title", content: @chat.title)
  # end
  #
  def perform(chat_id)
    chat = Chat.find(chat_id)

    user_message = chat.messages.where(role: :user).last
    return unless user_message

    assistant_message = chat.messages.create!(role: :assistant, content: "")

    RubyLLM.chat.with_instructions(instructions).ask(user_message.content) do |chunk|
      next unless chunk.content.present?

      assistant_message.update!(
        content: assistant_message.content.to_s + chunk.content
      )

      assistant_message.broadcast_replace_to(
        chat,
        target: ActionView::RecordIdentifier.dom_id(assistant_message),
        partial: "messages/message",
        locals: { message: assistant_message }
      )
    end
    old_title = chat.title
    chat.generate_title_from_first_message

    return unless chat.reload.title != old_title

    Turbo::StreamsChannel.broadcast_update_to(chat, target: "chat_title", content: chat.title)
  end

  # private

  # def broadcast_replace(message)
  #   Turbo::StreamsChannel.broadcast_replace_to(
  #     @chat,
  #     target: helpers.dom_id(message),
  #     partial: "messages/message", locals: { message: message }
  #   )
  # end
end

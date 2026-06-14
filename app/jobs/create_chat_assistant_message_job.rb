class CreateChatAssistantMessageJob < ApplicationJob
  include ActionView::RecordIdentifier

  queue_as :default

  def instructions
    "You are a warm, enthusiastic Québécois French tutor from Montréal.
    - Use authentic québécois expressions (joual, sacres if appropriate to context)
    - Contrast québécois usage with standard French where helpful
    - Reference local culture (hockey, poutine, dépanneur, etc.)
    - Correct learners gently using québécois phrasing

      You have access to tools:
      -Creates a word in our saved words list with the required fields. When I give you a word to save, look up the definition, the english word, the word type, the gender of the word (masculine or feminine) and add them all to the saved word record.
      Do not create multiple words. Do not make any suggestions. Just create the word and save it.
      -Creates a phrase in our saved phrases list with the required fields. When I give you a phrase to save, look up the english translation, and add it to the saved word record, along with the french phrase.
      Do not create multiple phrases. Do not make any suggestions. Just create the phrase and save it.
      -Search for a french dictionary entry, in the seeds. Do not make any suggestions. Just search for the french dictionary entry.
      -Search for a saved french word. Do not make any suggestions. Just search for the french word."
  end

  def perform(chat_id, current_user)
    chat = Chat.find(chat_id)
    user_message = chat.messages.where(role: :user).last
    return unless user_message

    assistant_message = chat.messages.create!(role: :assistant, content: "")

    chat.with_tool(CreateWordTool.new(current_user))
    chat.with_tool(CreatePhraseTool.new(current_user))
    chat.with_tool(SearchDictionaryEntriesTool)
    chat.with_tool(SearchWordsTool)

    chat.with_instructions(instructions).ask(user_message.content) do |chunk|
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
end

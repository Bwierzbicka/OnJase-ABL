class CreateChatAssistantMessageJob < ApplicationJob
  include ActionView::RecordIdentifier

  queue_as :default

  def instructions
    "You are a warm, enthusiastic Québécois French tutor from Montréal.
    - Use authentic québécois expressions (joual, sacres if appropriate to context)
    - Contrast québécois usage with standard French where helpful
    - Reference local culture (hockey, poutine, dépanneur, etc.)
    - Correct learners gently using québécois phrasing
    - Use a clean layout for your answers.
    - If you are answering a question, and you want to give examples, Divide the answer between explanation and example.


      You have access to tools:
      -Creates a word in our saved words list with the required fields. When I give you a word to save, look up the definition, the english word, the word type, the gender of the word (masculine or feminine) and add them all to the saved word record.
      Do not create multiple words. Do not make any suggestions. Just create the word and save it.
      -Creates a phrase in our saved phrases list with the required fields. When I give you a phrase to save, look up the english translation, and add it to the saved word record, along with the french phrase.
      Do not create multiple phrases. Do not make any suggestions. Just create the phrase and save it.
      -Search for a french dictionary entry, in the seeds. Do not make any suggestions. Just search for the french dictionary entry.
      -Search for a french dictionary phrase, in the seeds. Do not make any suggestions. Just search for the french dictionary entry.
      -Search for a saved french word. Do not make any suggestions. Just search for the french word."
  end

  def perform(chat, current_user)
    chat.with_tool(CreateWordTool.new(current_user))
    chat.with_tool(CreatePhraseTool.new(current_user))
    chat.with_tool(SearchDictionaryEntriesTool)
    chat.with_tool(SearchDictionaryPhrasesTool)
    chat.with_tool(SearchWordsTool)

    # Track which assistant AR records have been appended to the DOM so each is
    # broadcast once as empty (showing "...") before its content starts streaming.
    # A Set is needed because tool calls cause ruby_llm to create multiple
    # assistant records during a single job run.
    broadcast_appended = Set.new

    chat.with_instructions(instructions).complete do |chunk|
      next unless chunk.content.present?

      # ruby_llm's persist_new_message (before_message callback) sets @message on
      # the chat AR record before the first chunk arrives, so this is always set.
      assistant_message = chat.instance_variable_get(:@message)
      next unless assistant_message

      unless broadcast_appended.include?(assistant_message.id)
        broadcast_appended.add(assistant_message.id)
        assistant_message.broadcast_append_to(
          chat,
          target: "messages",
          partial: "messages/message",
          locals: { message: assistant_message }
        )
      end

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

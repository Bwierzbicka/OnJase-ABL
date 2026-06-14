class ConversationTypingAssistantJob < ApplicationJob
  queue_as :default

  def perform(user_conversation, current_user, message_text)
    @current_user    = current_user
    @conversation    = user_conversation
    @message_text    = message_text
    @messages        = @conversation.user_conversation_messages.last(5)

    response = RubyLLM.chat.with_schema(ConversationTypingAssistantSchema.new).ask(instructions).content

    Turbo::StreamsChannel.broadcast_update_to(
      "user_conversation_#{@conversation.id}_user_#{@current_user.id}",
      target: "conversation-typing-assistant",
      content: panel_content(response)
    )

    puts instructions
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

  def panel_content(response)
    expression   = response['expression'].to_s.strip
    explanation  = response['expression_explanation'].to_s.strip
    examples     = response['examples'].to_s.strip
    translation  = response['translation'].to_s.strip
    correction   = response['correction'].to_s.strip
    tone         = response['tone'].to_s.strip

    parts = []

    if expression.present?
      parts << <<~HTML
        <div class="mb-3">
          <div class="d-flex align-items-center flex-wrap gap-2 mb-2">
            <strong>#{expression}</strong>
            <span class="badge rounded-pill ai-panel__qc-badge">
            <i class="fa-regular fa-hand-point-up"></i> Expression québécoise</span>
          </div>
          #{"<p class=\"text-muted small mb-0\">#{explanation}</p>" if explanation.present?}
        </div>
      HTML
    end

    if examples.present?
      parts << <<~HTML
        <div class="mb-3">
          <div class="d-flex align-items-center gap-2 mb-2 ai-panel__section-label">
            <i class="fa-regular fa-lightbulb"></i>
            <small>Exemples similaires</small>
          </div>
          <div class="d-flex flex-wrap gap-2">
            <span class="rounded-3 p-2 ai-panel__section-box">#{examples}</span>
          </div>
        </div>
      HTML
    end

    if translation.present?
      parts << <<~HTML
        <div class="mb-3">
          <div class="d-flex align-items-center gap-2 mb-2 ai-panel__section-label">
            <i class="fa-solid fa-language"></i>
            <small>Traduction</small>
          </div>
          <div class="rounded-3 p-2 ai-panel__section-box">#{translation}</div>
        </div>
      HTML
    end

    if tone.present?
      parts << <<~HTML
        <div class="mb-3">
          <div class="d-flex align-items-center gap-2 mb-2 ai-panel__section-label">
            <i class="fa-solid fa-language"></i>
            <small>Tutoiement vs. Vouvoiement</small>
          </div>
          <div class="rounded-3 p-2 ai-panel__section-box">#{tone}</div>
        </div>
      HTML
    end

    if correction.present?
      parts << <<~HTML
        <div class="mb-1">
          <div class="d-flex align-items-center gap-2 mb-2 ai-panel__section-label">
            <i class="fa-solid fa-spell-check"></i>
            <small>Correction</small>
          </div>
          <div class="rounded-3 p-2 ai-panel__section-box">#{correction}</div>
        </div>
      HTML
    end

    parts.join
  end
end

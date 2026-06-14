class ConversationAssistantJob < ApplicationJob
  queue_as :default

  def perform(conversation, current_user)
    @current_user = current_user
    @conversation = conversation
    @messages = conversation.user_conversation_messages.last(4)

    response = RubyLLM.chat.with_schema(ConversationAssistantSchema.new).ask(instructions).content

    Turbo::StreamsChannel.broadcast_update_to(
      "user_conversation_#{@conversation.id}_user_#{@current_user.id}",
      target: "conversation-assistant",
      content: panel_content(response)
    )

    puts extract_messages
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

    If last messege is CURRENT user message:
    - Check last current user message and correct any mistakes.

    If last message is INCOMING message:
    - Analyse only the LAST incoming message for québécois expressions.
    - Suggest a short, natural next reply.
    - If the message is in French, translate it.

    For all responses:
    - Keep everything concise — one expression, 2-3 examples, one suggestion.

    Here are the latest messages: "
    #  - Translate last incoming message.
  end

  def panel_content(response)
    expression   = response['expression'].to_s.strip
    explanation  = response['expression_explanation'].to_s.strip
    examples     = response['examples'].to_s.strip
    suggestion   = response['suggestion'].to_s.strip
    translation  = response['translation'].to_s.strip
    correction   = response['correction'].to_s.strip

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
            <span class="rounded-3 p-2 ai-panel__suggestion-box">#{examples}</span>
          </div>
        </div>
      HTML
    end

    if suggestion.present?
      parts << <<~HTML
        <div class="mb-3">
          <div class="d-flex align-items-center gap-2 mb-2 ai-panel__section-label">
            <i class="fa-regular fa-comment"></i>
            <small>Réponse suggérée</small>
          </div>
          <div class="rounded-3 p-2 ai-panel__section-box">#{suggestion}</div>
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

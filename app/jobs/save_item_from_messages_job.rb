class SaveItemFromMessagesJob < ApplicationJob
  queue_as :default

  def instructions
    "You are a Québécois French tutor. Save the following item into the user's saved list.

   Rules:
    - Categorize the input as either a word or a phrase.
      If it is a word, use the word tool. If it is a phrase, use the phrase tool.
    - Always provide both the French and English versions.
      Translate using your own knowledge, prioritizing Québécois French where appropriate.
    - For words:
      include the French word,
      English translation,
      French definition,
      word type (noun/verb/adjective/etc.),
      gender (masculin or féminin — only for nouns).
    - Call the tool exactly once. Do not make suggestions or add commentary.

    Item to save: "
  end

  def perform(current_user, item)
    @current_user = current_user
    @item = item
    @chat = RubyLLM.chat
    phrase_tool = CreatePhraseTool.new(current_user)
    word_tool = CreateWordTool.new(current_user)
    @chat.with_tool(phrase_tool)
    @chat.with_tool(word_tool)
    @chat.with_instructions(instructions).ask(@item)

    if word_tool.created_word
      broadcast_saveable(target: "words-list", partial: "saved_items/word_card",
                         locals: { word: word_tool.created_word })
    elsif phrase_tool.created_phrase
      broadcast_saveable(target: "phrases-list", partial: "saved_items/phrase_card",
                         locals: { phrase: phrase_tool.created_phrase })
    end
  end

  private

  def broadcast_saveable(target:, partial:, locals:)
    Turbo::StreamsChannel.broadcast_prepend_to(
      [@current_user, "saved_items"],
      target: target,
      partial: partial,
      locals: locals
    )
  end
end

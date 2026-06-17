class SaveItemFromMessagesJob < ApplicationJob
  queue_as :default

  def instructions
    "You are a Québécois French tutor. Save the following item into the user's saved list.

    Rules:
    - If the item is a single word, use the word tool. If it is a multi-word expression or phrase, use the phrase tool.
    - Always provide both the French and English versions. Translate using your own knowledge.
    - For words: include the French word, English translation, French definition, word type (noun/verb/adjective/etc.), and gender (masculin or féminin — only for nouns).
    - Call the tool exactly once. Do not make suggestions or add commentary.

    Item to save: "
  end

  def perform(current_user, item)
    @current_user = current_user
    @item = item
    @chat = RubyLLM.chat
    @chat.with_tool(CreatePhraseTool.new(current_user))
    @chat.with_tool(CreateWordTool.new(current_user))
    @chat.with_instructions(instructions).ask(@item)
  end
end

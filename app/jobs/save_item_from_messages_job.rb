class SaveItemFromMessagesJob < ApplicationJob
  queue_as :default

  def instructions
    "You are a warm, enthusiastic Québécois French tutor from Montréal.
    - You are given word or phrase to save into our saved items lists.

    You have access to tools:
    - Creates a word in our saved words list with the required fields.
      When I give you a word to save, look up the definition, the english word,
      the word type, the gender of the word (masculine or feminine)
      and add them all to the saved word record.
      Do not create multiple words. Do not make any suggestions. Just create the word and save it.
    - Creates a phrase in our saved phrases list with the required fields.
      When I give you a phrase to save, look up the english translation,
      and add it to the saved phrase record, along with the french phrase.
      Do not create multiple phrases. Do not make any suggestions. Just create the phrase and save it.

    Here is an item I want to save: "
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

class CreatePhraseTool < RubyLLM::Tool
  description "Creates a phrase in our saved phrases list with the required fields.
  Use this whenever the user wants to save, bookmark, or add a phrase to their list
  — for example: 'save this phrase','add this to my saved phrases'."

  param :french_phrase_add, desc: "The French phrase I want to add.
                                   When translating from English, use a complete sentence where appropriate.
                                   Prefer Québécois French expressions when applicable."
  param :english_phrase_add, desc: "The English translation of the French phrase.
                                    Recognize Québécois expressions and translate them according to their intended meaning."

  attr_reader :created_phrase

  # When calling this tool you need to initialise it with an isntance of User
  def initialize(current_user)
    @user = current_user
  end

  def execute(french_phrase_add:, english_phrase_add:) # no need for phrase id
    phrase = Phrase.create!(french: french_phrase_add, english: english_phrase_add)
    SavedItem.create!(saveable: phrase, user: @user)
    @created_phrase = phrase
    { success: true, id: phrase.id }
  rescue ActiveRecord::RecordInvalid => e
    { error: e.message }
  end
end

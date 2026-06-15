class CreatePhraseTool < RubyLLM::Tool
  description "Creates a phrase in our saved phrases list with the required fields"
  param :french_phrase_add, desc: "The french phrase I want to add"
  # param :phrase_id, desc: "The ID of the phrase", type: :integer # not sure if needed, commented out for now
  param :english_phrase_add, desc: "The english translation of the phrase I want to add"

  # When calling this tool you need to initialise it with an isntance of User
  def initialize(current_user)
    @user = current_user
  end

  def execute(french_phrase_add:, english_phrase_add:) # no need for phrase id
    phrase = Phrase.create!(french: french_phrase_add, english: english_phrase_add)
    { success: true, id: phrase.id } # i asked claude to check and it said to add this. do i remove?
    SavedItem.create!(saveable: phrase, user: @user)
  rescue ActiveRecord::RecordInvalid => e
    { error: e.message }
  end
end

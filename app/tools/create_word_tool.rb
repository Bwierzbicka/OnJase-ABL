class CreateWordTool < RubyLLM::Tool
  description "Creates a word in our saved words list with the required fields.
  Use this whenever the user wants to save, bookmark, or add a word to their list
  — for example: 'save this word','add this to my saved words'."

  param :french_add, desc: "The french word I want to add"
  # param :word_id, desc: "The ID of the word", type: :integer # not sure if needed, commented out for now
  param :english_add, desc: "The english translation of the word I want to add"
  param :definition_add, desc: "The french definition of the word I want to add"
  param :word_type_add, desc: "The word type of the word I want to add"
  param :gender_add, desc: "The gender of the word I want to add"

  # When calling this tool you need to initialise it with an isntance of User
  def initialize(current_user)
    @user = current_user
  end

  def execute(french_add:, english_add:, definition_add:, word_type_add:, gender_add:) # no need for word id
    word = Word.create!(french: french_add,
                        english: english_add, definition: definition_add,
                        gender: gender_add, word_type: word_type_add)
    SavedItem.create!(saveable: word, user: @user)
  rescue ActiveRecord::RecordInvalid => e
    { error: e.message }
  end
end

class CreateWordTool < RubyLLM::Tool
  description "Creates a word in our saved words list with the required fields"
  param :word_id, "The ID of the word", type: :integer
  param :english_add, desc: "The english translation of the word I want to add"
  param :definition_add, desc: "The french definition of the word I want to add"
  param :word_type, desc: "The word type of the word I want to add"

  def execute(word_id:, english_add:, definition_add:, word_type:)
    word = Word.find(word_id)
  end
end

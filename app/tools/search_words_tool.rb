class SearchWordsTool < RubyLLM::Tool
  description "Search for a french word"
  param :query, desc: "The word to search for"

  def execute(query:)
    french_words = Word.all
    query.split.each do |word|
      french_words = french_words.where("french = :q", q: "#{word}")
    end
    return "No french words found for '#{query}'" if french_words.empty?

    french_words.map do |french_word|
      { id: french_word.id, definition: french_word.definition,
        english: french_word.english, french: french_word.french,
        word_type: french_word.word_type }
    end
  end
end

class SearchWordsTool < RubyLLM::Tool
  # search with neighbor and then llm chat
  description "Search for a saved french word"
  param :query, desc: "The french word to search for"

  def execute(query:)
    french_words = Word.all
    query.split.each do |word|
      french_words = french_words.where("french = :q", q: "#{word}")
    end
    return "No french word found for '#{query}'" if french_words.empty?

    french_words.map do |french_word|
      { id: french_word.id, definition: french_word.definition,
        english: french_word.english, french: french_word.french,
        word_type: french_word.word_type, gender: french_word.gender }
    end
  end
end

# claude correct since im looking for one word
# def execute(query:)
#   french_words = Word.where(french: query)
#   return "No french word found for '#{query}'" if french_words.empty?

#   french_words.map do |w|
#     { id: w.id, definition: w.definition, english: w.english,
#       french: w.french, word_type: w.word_type, gender: w.gender }
#   end
# end

# or match any of the words
# def execute(query:)
#   words = query.split
#   french_words = Word.where(french: words)
#   ...
# end

class SearchWordsTool < RubyLLM::Tool
  description "Search for a french word"
  param :query, desc: "The word to search for"

  def execute(query:)
    french_words = Word.all
    query.split.each d |word|
    french_words = french_words.where("french = :q", q: "#{word}")
  end
  return "No words found for '#{query}'" if words.empty?
end

class SearchDictionaryPhrasesTool < RubyLLM::Tool
  description "Search for a french dictionary phrase"
  param :query, desc: "The french dictionary phrase to search for"

  def execute(query:)
    embedding = RubyLLM.embed(query).vectors
    dictionary_phrase_results = DictionaryPhrase.nearest_neighbors(:embedding, embedding,
                                                                   distance: "euclidean").first(5)
    return "No dictionary phrases found for '#{query}'" if dictionary_phrase_results.empty?

    dictionary_phrase_results.each do |entry3|
      puts "#{entry3.french} (distance: #{entry3.neighbor_distance.round(4)})"
    end
  end
end

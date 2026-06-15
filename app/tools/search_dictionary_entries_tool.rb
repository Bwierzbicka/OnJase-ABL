class SearchDictionaryEntriesTool < RubyLLM::Tool
  description "Search for a french dictionary entry"
  param :query, desc: "The french dictionary entry to search for"

  def execute(query:)
    embedding = RubyLLM.embed(query).vectors
    dictionary_entry_results = DictionaryEntry.nearest_neighbors(:embedding, embedding, distance: "euclidean").first(5)

    return "No dictionary entries found for '#{query}'" if dictionary_entry_results.empty?

    dictionary_entry_results.each do |entry|
      puts "#{entry.terme_francais} (distance: #{entry.neighbor_distance.round(4)})"
    end
  end
end

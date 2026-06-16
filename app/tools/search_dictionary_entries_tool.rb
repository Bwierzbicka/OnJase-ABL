class SearchDictionaryEntriesTool < RubyLLM::Tool
  description "Search for a french dictionary entry"
  param :query, desc: "The french dictionary entry to search for"

  def execute(query:)
    embedding = RubyLLM.embed(query).vectors
    dictionary_entry_results = DictionaryEntry.nearest_neighbors(:embedding, embedding, distance: "euclidean").first(5)

    return "No dictionary entries found for '#{query}'" if dictionary_entry_results.empty?

  end
end

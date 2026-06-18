class FindSavedItemsTool < RubyLLM::Tool
  desc "Returns saved_items based on embeddings close to given query"
  param :embedded_query, desc: "embedded_query"

  def execute(embedded_query:)
    SavedItem.nearest_neighbors(:embedding, embedded_query, distance: "euclidean").first(15)
  rescue StandardError => e
    { error: e.message }
  end
end

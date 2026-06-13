class AddEmbeddingToDictionaryEntries < ActiveRecord::Migration[8.1]
  def change
    add_column :dictionary_entries, :embedding, :vector, limit: 1536
  end
end

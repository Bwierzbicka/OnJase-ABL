class AddEmbeddingToSavedItems < ActiveRecord::Migration[8.1]
  def change
    add_column :saved_items, :embedding, :vector, limit: 1536
  end
end

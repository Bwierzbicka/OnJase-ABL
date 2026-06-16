class CreateDictionaryPhrases < ActiveRecord::Migration[8.1]
  def change
    create_table :dictionary_phrases do |t|
      t.text :english
      t.text :french
      t.vector :embedding, limit: 1536

      t.timestamps
    end
  end
end

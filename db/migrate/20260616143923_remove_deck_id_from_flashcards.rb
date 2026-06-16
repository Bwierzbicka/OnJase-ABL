class RemoveDeckIdFromFlashcards < ActiveRecord::Migration[8.1]
  def change
    remove_reference :flashcards, :deck, null: false, foreign_key: true
  end
end

class AddDeckToFlashcards < ActiveRecord::Migration[8.1]
  def change
    add_reference :flashcards, :deck, null: false, foreign_key: true
  end
end

class CreateDeckFlashcards < ActiveRecord::Migration[7.1]
  def change
    create_table :deck_flashcards do |t|
      t.references :deck, null: false, foreign_key: true
      t.references :flashcard, null: false, foreign_key: true

      t.timestamps
    end
  end
end

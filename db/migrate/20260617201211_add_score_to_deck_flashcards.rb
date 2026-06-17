class AddScoreToDeckFlashcards < ActiveRecord::Migration[8.1]
  def change
    add_column :deck_flashcards, :correct_count, :integer, default: 0, null: false
    add_column :deck_flashcards, :attempt_count, :integer, default: 0, null: false
  end
end

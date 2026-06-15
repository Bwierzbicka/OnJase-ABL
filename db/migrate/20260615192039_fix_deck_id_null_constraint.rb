
class FixDeckIdNullConstraint < ActiveRecord::Migration[7.1]
  def change
    change_column_null :flashcards, :deck_id, true
  end
end

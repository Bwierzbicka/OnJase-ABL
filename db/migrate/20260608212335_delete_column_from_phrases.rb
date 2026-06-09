class DeleteColumnFromPhrases < ActiveRecord::Migration[8.1]
  def change
    remove_column :phrases, :translation, :string
  end
end

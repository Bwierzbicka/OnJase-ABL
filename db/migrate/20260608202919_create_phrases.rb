class CreatePhrases < ActiveRecord::Migration[8.1]
  def change
    create_table :phrases do |t|
      t.string :french
      t.string :english
      t.string :translation

      t.timestamps
    end
  end
end

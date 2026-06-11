class CreateDictionaryEntries < ActiveRecord::Migration[8.1]
  def change
    create_table :dictionary_entries do |t|
      t.text :terme_francais
      t.text :terme_anglais
      t.text :definition
      t.string :gender
      t.string :word_type

      t.timestamps
    end
  end
end

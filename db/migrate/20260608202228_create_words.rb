class CreateWords < ActiveRecord::Migration[8.1]
  def change
    create_table :words do |t|
      t.string :french
      t.string :english
      t.text :definition
      t.string :type

      t.timestamps
    end
  end
end

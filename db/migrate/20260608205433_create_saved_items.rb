class CreateSavedItems < ActiveRecord::Migration[8.1]
  def change
    create_table :saved_items do |t|
      t.belongs_to :saveable, polymorphic: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

class CreateUserConversations < ActiveRecord::Migration[8.1]
  def change
    create_table :user_conversations do |t|
      t.timestamps
      t.bigint :user_id_1, null: false
      t.bigint :user_id_2, null: false
    end

    add_index :user_conversations, :user_id_1
    add_index :user_conversations, :user_id_2
    add_index :user_conversations, [ :user_id_1, :user_id_2 ], unique: true
    add_foreign_key :user_conversations, :users, column: :user_id_1
    add_foreign_key :user_conversations, :users, column: :user_id_2
  end
end

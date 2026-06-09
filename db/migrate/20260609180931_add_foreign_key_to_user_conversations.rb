class AddForeignKeyToUserConversations < ActiveRecord::Migration[8.1]
  def change
    add_reference :user_conversation_messages, :user_conversation, null: false, foreign_key: true
  end
end

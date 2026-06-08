class CreateUserConversationMessages < ActiveRecord::Migration[8.1]
  def change
    create_table :user_conversation_messages do |t|
      t.string :content
      t.string :user_id
      t.string :translation

      t.timestamps
    end
  end
end

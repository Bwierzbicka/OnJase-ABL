class ChangeUserIdTypeFromStringToIntegerInUserConversationMessages < ActiveRecord::Migration[8.1]
  def change
    change_column :user_conversation_messages, :user_id, 'integer USING CAST(user_id AS integer)'
  end
end

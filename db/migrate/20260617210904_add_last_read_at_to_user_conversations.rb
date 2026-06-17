class AddLastReadAtToUserConversations < ActiveRecord::Migration[8.1]
  def change
    add_column :user_conversations, :last_read_at_user1, :datetime
    add_column :user_conversations, :last_read_at_user2, :datetime
  end
end

class UserConversationMessage < ApplicationRecord
  after_create_commit :broadcast_append_to_user_conversation
  validates :content, presence: true
  validates :user_id, presence: true
  belongs_to :user_conversation

  private

  def broadcast_append_to_user_conversation
    user_ids = [user_conversation.user_id_1, user_conversation.user_id_2].uniq

    user_ids.each do |uid|
      broadcast_append_to(
        "user_conversation_#{user_conversation.id}_user_#{uid}",
        target: "user_conversation_messages",
        partial: "user_conversation_messages/user_conversation_message",
        locals: { user_conversation_message: self, current_user_id: uid }
      )

      user = User.find(uid)
      broadcast_replace_to(
        "user_conversations_user_#{uid}",
        target: "user_conversation_#{user_conversation.id}",
        partial: "user_conversations/conversation",
        locals: { conversation: user_conversation, current_user: user }
      )
    end
  end
end

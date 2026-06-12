class UserConversationMessage < ApplicationRecord
  after_create_commit :broadcast_append_to_user_conversation
  validates :content, presence: true
  validates :user_id, presence: true
  belongs_to :user_conversation

  private

  def broadcast_append_to_user_conversation
    [user_conversation.user_id_1, user_conversation.user_id_2].each do |uid|
      broadcast_append_to(
        "user_conversation_#{user_conversation.id}_user_#{uid}",
        target: "user_conversation_messages",
        partial: "user_conversation_messages/user_conversation_message",
        locals: { user_conversation_message: self, current_user_id: uid }
      )
    end
  end
end

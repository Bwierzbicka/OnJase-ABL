class UserConversationMessage < ApplicationRecord
  after_create_commit :broadcast_append_to_user_conversation
  validates :content, presence: true
  validates :user_id, presence: true
  belongs_to :user_conversation

  private

  def broadcast_append_to_user_conversation
    broadcast_append_to user_conversation, target: "user_conversation_messages",
                                           partial: "user_conversation_messages/user_conversation_message",
                                           locals: { user_conversation_message: self }
  end
end

class UserConversation < ApplicationRecord
  attr_accessor :username

  belongs_to :user1, class_name: "User", foreign_key: :user_id_1
  belongs_to :user2, class_name: "User", foreign_key: :user_id_2
  validates :user_id_1, presence: true, uniqueness: { scope: :user_id_2 }
  validates :user_id_2, presence: true
  has_many :user_conversation_messages, dependent: :destroy

  def other_participant(user)
    user_id_1 == user.id ? user2 : user1
  end

  def unread_for?(user)
    last_message = user_conversation_messages.last
    return false unless last_message
    return false if last_message.user_id == user.id

    last_read = user_id_1 == user.id ? last_read_at_user1 : last_read_at_user2
    last_read.nil? || last_message.created_at > last_read
  end

  def mark_read_for!(user)
    column = user_id_1 == user.id ? :last_read_at_user1 : :last_read_at_user2
    update_column(column, Time.current)
  end
end

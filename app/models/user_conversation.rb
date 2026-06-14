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
end

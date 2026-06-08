class UserConversation < ApplicationRecord
  belongs_to :user1, class_name: "User", foreign_key: :user_id_1
  belongs_to :user2, class_name: "User", foreign_key: :user_id_2
  validates :user_id_1, uniqueness: { scope: :user_id_2 }
  validates :user_id_2, presence: true
  validates :content, presence: true
end

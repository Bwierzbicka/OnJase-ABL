class UserConversationMessage < ApplicationRecord
  validates :content, presence: true
  validates :user_id, presence: true
  belongs_to :user_conversation
end

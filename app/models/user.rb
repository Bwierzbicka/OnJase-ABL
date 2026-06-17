class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar

  validates :username, presence: true, uniqueness: true
  has_many :chats, dependent: :destroy
  has_many :saved_items, dependent: :destroy
  has_many :saved_words, through: :saved_items, source: :saveable, source_type: 'Word'
  has_many :saved_phrases, through: :saved_items, source: :saveable, source_type: 'Phrase'
  has_many :user_conversations_as_user1, class_name: "UserConversation", foreign_key: :user_id_1, dependent: :destroy
  has_many :user_conversations_as_user2, class_name: "UserConversation", foreign_key: :user_id_2, dependent: :destroy
  has_many :flashcards, dependent: :destroy
  has_many :decks, dependent: :destroy

  def user_conversations
    UserConversation.where("user_id_1 = ? OR user_id_2 = ?", id, id)
  end
end

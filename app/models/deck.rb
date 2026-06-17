class Deck < ApplicationRecord
  belongs_to :user
  has_many :flashcards, through: :deck_flashcards

  validates :name, presence: true
end

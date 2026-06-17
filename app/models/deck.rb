class Deck < ApplicationRecord
  belongs_to :user

  has_many :deck_flashcards, dependent: :destroy
  has_many :flashcards, through: :deck_flashcards

  validates :name, presence: true
end

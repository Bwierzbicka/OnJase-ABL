class Flashcard < ApplicationRecord
  belongs_to :user
  has_many :deck_flashcards, dependent: :destroy
  has_many :decks, through: :deck_flashcards

  validates :question, presence: true
  validates :answer, presence: true
end

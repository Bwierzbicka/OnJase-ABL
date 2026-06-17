class Deck < ApplicationRecord
  belongs_to :user

  has_many :deck_flashcards, dependent: :destroy
  has_many :flashcards, through: :deck_flashcards

  validates :name, presence: true

  # Returns a Float 0.0–1.0 across all attempted cards, or nil if none attempted yet.
  def score
    attempted = deck_flashcards.where("attempt_count > 0")
    return nil if attempted.empty?

    total_correct = attempted.sum(:correct_count)
    total_attempts = attempted.sum(:attempt_count)
    total_correct.to_f / total_attempts
  end
end

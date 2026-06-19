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

  def score_tier
    return :none if score.nil?
    return :low  if score < 0.5
    return :medium if score < 0.75

    :high
  end

  scope :low_score, lambda {
    joins(:deck_flashcards)
      .where("deck_flashcards.attempt_count > 0")
      .group("decks.id")
      .having("SUM(deck_flashcards.correct_count)::float / SUM(deck_flashcards.attempt_count) < ?", 0.4)
  }
end

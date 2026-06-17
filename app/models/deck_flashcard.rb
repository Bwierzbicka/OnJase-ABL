class DeckFlashcard < ApplicationRecord
  belongs_to :deck
  belongs_to :flashcard

  def score
    return nil if attempt_count.zero?

    correct_count.to_f / attempt_count
  end
end

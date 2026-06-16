class DeckFlashcard < ApplicationRecord
  belongs_to :deck
  belongs_to :flashcard
end

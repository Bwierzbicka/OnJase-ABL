class Word < ApplicationRecord
  WORD_TYPE = %w[noun verb article adjective pronoun adverb preposition conjunction interjection]

  has_many :saved_items, as: :saveable

  validates :word_type, inclusion: { in: WORD_TYPE }
  validates :french, presence: true
  validates :english, presence: true
  validates :definition, presence: true
end

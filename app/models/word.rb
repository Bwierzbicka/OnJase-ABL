class Word < ApplicationRecord
  WORD_TYPE = %w[nom verbe article adjectif pronom adverbe préposition conjonction interjection]

  has_many :saved_items, as: :saveable

  validates :word_type, inclusion: { in: WORD_TYPE }
  validates :french, presence: true
  validates :english, presence: true
  validates :definition, presence: true
end

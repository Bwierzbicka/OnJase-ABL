class Phrase < ApplicationRecord
  has_many :saved_items, as: :saveable
  validates :french, presence: true
  validates :english, presence: true
end

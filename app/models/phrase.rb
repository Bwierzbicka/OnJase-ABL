class Phrase < ApplicationRecord
  has_many :saved_items, as: :saveable, dependent: :destroy
  validates :french, presence: true
  validates :english, presence: true
end

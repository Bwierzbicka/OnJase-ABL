class Phrase < ApplicationRecord
  has_many :saved_items, as: :saveable
end

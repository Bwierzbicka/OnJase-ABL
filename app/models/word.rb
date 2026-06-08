class Word < ApplicationRecord
  has_many :saved_items, as: :saveable
end

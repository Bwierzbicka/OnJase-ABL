class SavedItem < ApplicationRecord
  belongs_to :saveable, polymorphic: true
  belongs_to :user
  has_neighbors :embedding
end

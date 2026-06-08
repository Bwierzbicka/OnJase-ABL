class SavedItem < ApplicationRecord
  belongs_to :saveable, polymorphic: true
end

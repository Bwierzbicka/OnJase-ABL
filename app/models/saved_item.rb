class SavedItem < ApplicationRecord
  belongs_to :saveable, polymorphic: true
  belongs_to :user
end

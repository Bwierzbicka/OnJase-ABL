class DictionaryEntry < ApplicationRecord
  # embedding  needs to be done here
  has_neighbors :embedding
end

class Flashcard < ApplicationRecord
  belongs_to :user
  belongs_to :deck, optional: true

  validates :question, presence: true
  validates :answer, presence: true
end

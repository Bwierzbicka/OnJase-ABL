class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :saved_items, dependent: :destroy
  has_many :saved_words, through: :saved_items, source: :saveable, source_type: 'Word'
  has_many :saved_phrases, through: :saved_items, source: :saveable, source_type: 'Phrase'
end

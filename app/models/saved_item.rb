class SavedItem < ApplicationRecord
  belongs_to :saveable, polymorphic: true
  belongs_to :user
  has_neighbors :embedding

  after_create :set_embedding

  private

  def set_embedding
    update!(embedding: RubyLLM.embed("#{saveable.english},#{saveable.french}").vectors)
  end
end

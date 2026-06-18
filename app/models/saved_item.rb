class SavedItem < ApplicationRecord
  belongs_to :saveable, polymorphic: true
  belongs_to :user
  has_neighbors :embedding
  after_create :set_embedding

  private

  def set_embedding
    embedding = RubyLLM.embed("#{saveable.english},#{saveable.french}")
    update(embedding: embedding.vectors)
  end
end

class SavedItemsController < ApplicationController
  def index
    @saved_words = current_user.saved_words
    @saved_phrases = current_user.saved_phrases
  end

  #   def new
  #   @saved_item = SavedItem.new
  #   @saved_item
  # end

  # def create

  # end
end

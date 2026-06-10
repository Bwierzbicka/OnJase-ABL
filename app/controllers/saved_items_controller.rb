class SavedItemsController < ApplicationController
  def index
    @saved_words = current_user.saved_words
    @saved_phrases = current_user.saved_phrases
  end
end

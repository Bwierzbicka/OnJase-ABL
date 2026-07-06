class SavedItemsController < ApplicationController
  def index
    @saved_words = current_user.saved_words
    @saved_phrases = current_user.saved_phrases
  end

  def create
    SaveItemFromMessagesJob.perform_later(current_user, params[:item].to_s)
    head :ok
  end
end

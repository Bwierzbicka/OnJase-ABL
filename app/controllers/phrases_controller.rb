class PhrasesController < ApplicationController
  def index
    @phrases = current_user.saved_phrases
  end

  def new
    @phrase = Phrase.new
  end

  def show
    @phrase = current_user.saved_phrases.find(params[:id])
  end

  def destroy
    @phrase = current_user.saved_phrases.find(params[:id])
    @phrase.destroy

    redirect_to saved_items_path
  end
end

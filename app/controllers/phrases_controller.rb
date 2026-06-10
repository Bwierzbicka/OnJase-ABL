class PhrasesController < ApplicationController
  def index
    @phrases = current_user.saved_phrases
  end

  def new
    @phrase = Phrase.new
  end

  def show
    @phrase = Phrase.find(params[:id])
  end
end

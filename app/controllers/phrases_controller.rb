class PhrasesController < ApplicationController
  def index
    @phrases = current_user.phrases
  end

  def new
    @phrase = Phrase.new
  end
end

class WordsController < ApplicationController
  def index
    @words = current_user.saved_words
  end

  def new
    @word = Word.new
  end

  def show
    @word = Word.find(params[:id])
  end
end

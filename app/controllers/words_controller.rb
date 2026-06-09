class WordsController < ApplicationController
  def index
    @words = current_user.words
  end

  def new
    @word = Word.new
  end
end

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

  def destroy
    @word = Word.find(params[:id])
    @word.destroy

    redirect_to saved_items_path
  end
end

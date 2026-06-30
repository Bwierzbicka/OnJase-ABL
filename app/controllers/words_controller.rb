class WordsController < ApplicationController
  def index
    @words = current_user.saved_words
  end

  def new
    @word = Word.new
  end

  def show
    @word = current_user.saved_words.find(params[:id])
  end

  def update
    @word = current_user.saved_words.find(params[:id])
    @word.update!(word_params)
    redirect_to @word
  end

  def destroy
    @word = current_user.saved_words.find(params[:id])
    @word.destroy

    redirect_to saved_items_path
  end

  private

  def word_params
    params.require(:word).permit(:french, :english, :definition, :gender, :word_type)
  end
end

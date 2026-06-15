class FlashcardsController < ApplicationController
  before_action :set_flashcard, only: %i[show edit update destroy]

  def index
    @flashcards = current_user.flashcards
  end

  def show
  end

  def new
    @flashcard = Flashcard.new
  end

  def create
    @flashcard = Flashcard.new(flashcard_params)
    @flashcard.user = current_user # assuming Devise or similar

    if @flashcard.save
      redirect_to @flashcard, notice: "Flashcard created!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @flashcard.update(flashcard_params)
      redirect_to @flashcard, notice: "Flashcard updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @flashcard.destroy
    redirect_to flashcards_path, notice: "Flashcard deleted."
  end

  private

  def set_flashcard
    @flashcard = Flashcard.find(params[:id])
  end

  def flashcard_params
    params.require(:flashcard).permit(:question, :answer)
  end
end

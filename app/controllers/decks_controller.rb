class DecksController < ApplicationController
  before_action :set_deck, only: %i[show edit update destroy play_deck record_score]

  def index
    @decks = current_user.decks.sort_by { |deck| deck.score || Float::INFINITY }
  end

  def show
    @flashcards = @deck.flashcards
  end

  def new
    @deck = Deck.new
  end

  def create
    @deck = current_user.decks.build(deck_params)
    if @deck.save
      redirect_to @deck
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @deck.update(deck_params)
      redirect_to @deck
    else
      render :edit
    end
  end

  def destroy
    @deck.destroy
    redirect_to decks_path
  end

  def create_deck
    embedding = RubyLLM.embed(params[:query])
    # TODO: run embedded query into tool
    SavedItem.nearest_neighbors(:embedding, embedded_query, distance: "euclidean").first(15)
  end

  def play_deck
    @flashcards = @deck.flashcards
  end

  def record_score
    deck_flashcard = @deck.deck_flashcards.find_by!(flashcard_id: params[:flashcard_id])
    deck_flashcard.increment!(:attempt_count)
    deck_flashcard.increment!(:correct_count) if params[:correct] == "true"
    render json: { score: @deck.score }
  end

  private

  def set_deck
    @deck = Deck.find(params[:id])
  end

  def deck_params
    params.require(:deck).permit(:name)
  end
end

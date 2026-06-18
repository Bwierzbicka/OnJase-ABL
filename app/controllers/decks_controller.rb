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
    instructions1 = <<~TEXT
      You are an agent that interprets a user query and modifies it to give more context
      which will be used later for embedding and title generation. The tool will search for
      words and phrases related to the original query in a database e.g. asking for formal
      will return words and phrases used in a professional setting. The items returned will
      have a french and english field which should be considered in the response.
    TEXT

    chat1 = RubyLLM.chat.with_instructions(instructions1)
    modified_query = chat1.ask(params[:query]).content
    embedded_query = RubyLLM.embed(modified_query).vectors

    results = SavedItem.nearest_neighbors(:embedding, embedded_query, distance: "euclidean").first(10)

    instructions2 = <<~TEXT
      Create a deck of flashcards with the given tool. The tool takes a single parameter
      of the name for the deck. Use the following text to create a name for the deck that
      is short. #{modified_query}
    TEXT

    chat2 = RubyLLM.chat.with_instructions(instructions2)
    chat2.with_tool(CreateFlashcardsFromSavedItemsTool.new(current_user, results))
    chat2.ask("Create a new Deck of flashcards")

    redirect_to decks_path
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

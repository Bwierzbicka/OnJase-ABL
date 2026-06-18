class CreateFlashcardsFromSavedItemsTool < RubyLLM::Tool
  description "Create Decks of flashcards from saved words.You will be given a set of saved words.
  Use this whenever the user wants to save, or bookmark flashcards
  — for example: 'create flashcards','create these flashcards', 'bookmark these flashcards'."
  param :deck_name, desc: "The name of the deck I'm creating"
  # @saved_items already has what i need param :saved_items, desc: "Words to be turned into flashcards and saved to a deck"

  attr_reader :created_deck

  def initialize(current_user, saved_items)
    # super()
    @user = current_user
    @saved_items = saved_items
  end

  def execute(deck_name:)
    @created_deck = Deck.create!(name: deck_name, user: @user)
    @saved_items.each do |saved_item|
      flashcard = Flashcard.create!(question: saved_item.saveable.french, answer: saved_item.saveable.english,
                                    user: @user)
      DeckFlashcard.create!(deck: @created_deck, flashcard: flashcard)
    end
  end
end

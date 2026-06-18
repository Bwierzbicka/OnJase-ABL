class CreateFlashcardsFromSavedItemsTool < RubyLLM::Tool
  description "Create Flashcards from saved words.You will be given a set of saved words.
  Use this whenever the user wants to save, or bookmark flashcards
  — for example: 'create flashcards','create these flashcards', 'bookmark these flashcards'."
  param :deck_name, desc: "The name of the deck I'm creating"
  # @saved_items already has what i need param :saved_items, desc: "Words to be turned into flashcards and saved to a deck"

  def initialize(current_user, saved_items)
    # super()
    @user = current_user
    @saved_items = saved_items
  end

  def execute(deck_name:)
    new_deck = Deck.create!(name: deck_name, user: @user)
    @saved_items.each do |saved_item|
      Flashcard.create!(french: saved_item.saveable.french, english: saved_item.saveable.english, deck: new_deck)
    end
  end
end

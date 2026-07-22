class CreateDeckJob < ApplicationJob
  queue_as :default

  def perform(user, query)
    instructions1 = <<~TEXT
      You are an agent that interprets a user query and modifies it to give more context
      which will be used later for embedding and title generation. The tool will search for
      words and phrases related to the original query in a database e.g. asking for formal
      will return words and phrases used in a professional setting. The items returned will
      have a french and english field which should be considered in the response.
    TEXT

    chat1 = RubyLLM.chat.with_instructions(instructions1)
    modified_query = chat1.ask(query).content
    embedded_query = RubyLLM.embed(modified_query).vectors

    results = SavedItem.nearest_neighbors(:embedding, embedded_query, distance: "euclidean").first(10)
    items = results.filter_map { |r| { id: r.id, french: r.saveable.french, english: r.saveable.english } if r.saveable }

    instructions2 = <<~TEXT
      You are a filter. The user has a learning goal described below. You will be given a list of vocabulary items,
      each with an id, a French word/phrase, and an English translation.
      Return only the IDs of items that are relevant and appropriate for the learning goal.
      Respond with a JSON array of integers only, no explanation. Example: [1, 4, 7]
      Learning goal: #{modified_query}
    TEXT

    chat2 = RubyLLM.chat.with_instructions(instructions2)
    filtered_ids = JSON.parse(chat2.ask(items.to_json).content)
    filtered_results = SavedItem.where(id: filtered_ids)

    instructions3 = <<~TEXT
      Create a deck of flashcards with the given tool. The tool takes a single parameter
      of the name for the deck. Use the following text to create a name for the deck that
      is short. #{modified_query}
    TEXT

    tool = CreateFlashcardsFromSavedItemsTool.new(user, filtered_results)
    chat3 = RubyLLM.chat.with_instructions(instructions3)
    chat3.with_tool(tool)
    chat3.ask("Create a new Deck of flashcards")

    Turbo::StreamsChannel.broadcast_append_to(
      [user, "decks"],
      target: "decks-list",
      partial: "decks/deck_card",
      locals: { deck: tool.created_deck }
    )
  end
end

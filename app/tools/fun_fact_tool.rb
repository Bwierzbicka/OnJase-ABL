class FunFactTool < RubyLLM::Tool
  description "Write an interesting fun fact about Quebec for someone who is visiting the state
  in the fun fact box in our dashboard. Just write the fun fact, no need to write for example fun fact:."
  param :fact, desc: "The Quebec fun fact i want to add"

  def execute(fact:)
    FunFact.create!(fact: fact)
  end
end

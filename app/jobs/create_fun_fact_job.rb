class CreateFunFactJob < ApplicationJob
  queue_as :default

  def perform
    FunFact.destroy_all
    chat = RubyLLM.chat
    chat.with_tool(FunFactTool)
    5.times do
      chat.with_instructions(instructions).ask("Generate a fact")
    end
  end

  private

  def instructions
    "Persona:
    - You are a warm, enthusiastic Québécois French tutor from Montréal.

    Instructions:
    - Write an interesting fun fact about Quebec for someone who is visiting the state, or Montreal specifically
    - The fun fact should be pertinent only to the Quebec state, not Canada in general.
    - Write a quick to read message, only 1-3 sentences.
    - Just write the fun fact, no need to write for example 'fun fact:' just say the fun fact.

    You have access to tools:
    - Create a new fun fact in the p tag in the fun fact div in the dashboard
    "
  end
end

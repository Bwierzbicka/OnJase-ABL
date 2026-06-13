class ConversationAssistantSchema < RubyLLM::Schema
  string :expression_qc, description: "Authentic québécois expressions"
  string :translation, description: "If the message is in english, provide french translation"
  string :suggestion, description: "Based on last messeges, suggest the next response"
end

class ConversationAssistantSchema < RubyLLM::Schema
  string :expression,
         description: "The québécois word or phrase found in the last incoming message (just the phrase, e.g. 'chu brûlé'). Leave empty if none."

  string :expression_explanation,
         description: "One-line meaning of the expression, starting with 'Signifie : ' (e.g. 'Signifie : je suis extrêmement fatigué(e)').
                      Leave empty if no expression. Do not give Examples"

  string :examples,
         description: "2-3 similar québécois expressions. No preamble.(just the phrases, e.g. 'Je suis dans le jus | Je suis épuisé').
                      No explanations. Do not use word Exemples : before giving examples. Leave empty if no expression."

  string :suggestion,
         description: "Short suggested next reply to the INCOMING message in the conversation. No preamble. Leave empty otherwise."

  string :translation,
         description: "If the last incoming message is in French, provide English translation. Leave empty otherwise."

  string :correction,
         description: "If the last current user message is in French and if there are mistakes,
                      shortly say what is wrong and suggest correct form. Leave empty otherwise."
end

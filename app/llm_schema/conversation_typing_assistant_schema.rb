class ConversationTypingAssistantSchema < RubyLLM::Schema
  string :expression,
         description: "The québécois word or phrase that could replace standard french expression.
                      make sure the tone is right ( tu/vous )
                      (just the phrase, e.g. 'chu brûlé'). Leave empty if none."

  string :expression_explanation,
         description: "One-line meaning of the expression, starting with
                      'Signifie : ' (e.g. 'Signifie : je suis extrêmement fatigué(e)').
                      Leave empty if no expression. Do not give Examples"

  string :examples,
         description: "1 similar québécois expression. No preamble.
                      Do not write 'Example: ', 'Exemples: ', 'Ex. 1', 'Ex. 2',
                      just the phrase,e.g. 'Je suis dans le jus'.
                      Leave empty if no expression."

  string :translation,
         description: "If the typed message is in English, provide French translation.
                      Leave empty if none."

  string :correction,
         description: "If the typed message is in French and if there are mistakes,
                      shortly say what is wrong and suggest correct form. Leave empty otherwise."
  string :tone,
         description: "Compare previous messages and make sure typed message is using the right tone.
                      if the tone doesnt match prevois messages (tu/vous), suggest correction.
                      Leave empty if correct."
end

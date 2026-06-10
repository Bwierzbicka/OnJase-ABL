class SaveFileTool < RubyLLM::Tool
  description "save content to file"

  params :path, desc: "fichier sauvegarder"
  params :content, desc: "contenu du fichier"

  def execute(path:, content:)
    phrase = Phrase.create!(
      path: path,
      content: content
    )

    halt "Pharse enregistrer avec succes (ID: #{phrase.id})"
  end
end


puts "#{DictionaryEntry.count} dictionary entries are being destroyed. Please wait."
DictionaryEntry.destroy_all
puts "Dictionary entries have been destroyed!"
Message.destroy_all
Chat.destroy_all
UserConversationMessage.destroy_all
UserConversation.destroy_all
SavedItem.destroy_all
Phrase.destroy_all
Word.destroy_all
User.destroy_all

user = User.create!(
  email: "test@example.com",
  password: "password123",
  password_confirmation: "password123",
  username: "user 1"
)

word1 = Word.create!(
  french: "maison",
  english: "house",
  definition: "A building used as a home",
  word_type: "noun"
)

word2 = Word.create!(
  french: "courir",
  english: "to run",
  definition: "To move swiftly on foot",
  word_type: "verb"
)

phrase1 = Phrase.create!(
  french: "Bonjour, comment ça va ?",
  english: "Hello, how are you?"
)

phrase2 = Phrase.create!(
  french: "Je ne comprends pas",
  english: "I don't understand"
)

SavedItem.create!(user: user, saveable: word1)
SavedItem.create!(user: user, saveable: word2)
SavedItem.create!(user: user, saveable: phrase1)
SavedItem.create!(user: user, saveable: phrase2)

user2 = User.create!(
  email: "autre@example.com",
  password: "password123",
  password_confirmation: "password123",
  username: "user 2"
)

conversation = UserConversation.create!(user1: user, user2: user2)

UserConversationMessage.create!(
  user_conversation_id: conversation.id,
  user_id: user.id.to_s,
  content: "Hey! How are you doing?"
)
UserConversationMessage.create!(
  user_conversation_id: conversation.id,
  user_id: user2.id.to_s,
  content: "Ça va bien, merci ! Et toi ?",
  translation: "I'm doing well, thanks! And you?"
)
UserConversationMessage.create!(
  user_conversation_id: conversation.id,
  user_id: user.id.to_s,
  content: "All good! Do you want to practice some French today?"
)
UserConversationMessage.create!(
  user_conversation_id: conversation.id,
  user_id: user2.id.to_s,
  content: "Oui, bien sûr ! Commençons.",
  translation: "Yes, of course! Let's start."
)

chat = Chat.create!(user: user, title: "French vocabulary help")

Message.create!(chat: chat, role: "user", content: "Can you help me understand when to use 'tu' vs 'vous' in French?")
Message.create!(chat: chat, role: "assistant", content: "Of course! 'Tu' is the informal singular 'you', used with friends, family, and children. 'Vous' is the formal or plural 'you', used with strangers, authority figures, or when addressing multiple people.")
Message.create!(chat: chat, role: "user", content: "That makes sense! So I should use 'vous' when talking to my French teacher?")

Logic for the Dictionary Entries from CSV starts here
require "csv"

filepath = "data/oqlf_2026-01-19.csv"

MASCULINE = /\(\s*n\.\s*m\.(?:\s*pl\.)?\s*\)/

FEMININE = /\(\s*n\.\s*f\.(?:\s*pl\.)?\s*\)/

BOTH = /\(\s*n\.\s*m\.\s*ou\s*f\.(?:\s*pl\.)?\s*\)/

def gender(text)

  return nil if text.nil?

  markers = text.scan(/\([^)]*\)/) # ALL (...) groups → array

  marker = markers.find { |m| m !~ /\(loc\./ } # first that isn't (loc.)

  return nil unless marker

    case marker

    when BOTH then :both

    when MASCULINE then :masculine

    when FEMININE then :feminine

    end

end

POS_PATTERNS = {

noun: /\(n\./, # (n.m. (n.f. (n.m. et f. — all just "noun"

verb: /\(v\./,

article: /\(art\./, # didn't find any in CSV

adjective: /\(adj\./,

pronoun: /\(pron\./, # didn't find any in CSV

adverb: /\(adv\./,

preposition: /\(prép\./,

conjunction: /\(conj\./, # didn't find any in CSV

interjection: /\(interj\./

}

def categorize(text)

  return nil if text.nil?

	markers = text.scan(/\([^)]*\)/) # ALL (...) groups → array

	marker = markers.find { |m| m !~ /\(loc\./ } # first that isn't (loc.)

	return nil unless marker

	POS_PATTERNS.each { |label, pattern| return label if marker =~ pattern }

	nil

end

# Dictionary entries generated for first(n) records of CSV. n=50
puts "Dictionary entries are being generated, from the first n CSV entries. Please wait." # CSV.foreach(filepath).first(n) do |row|
CSV.foreach(filepath).first(50) do |row| #replace 50 by the number we want to generate. if we want all just remove .first(50)
  g = gender(row[0])
  w = categorize(row[0])
  next if g.nil? || w.nil?
  DictionaryEntry.create!(terme_francais: row[0], terme_anglais: row[1], definition: row[2], gender: g, word_type: w)
end
puts "#{DictionaryEntry.count} dictionary entries were created successfully!"


# Costs .01 USD per 50, 10 USD for the whole thing
puts "Embedding #{DictionaryEntry.count} dictionary entries are being generated. Please wait."
DictionaryEntry.each do |entry|
  str = ""
  str.concat(entry.terme_francais, entry.terme_anglais, entry.definition, entry.gender, entry.word_type)
  embedding = RubyLLM.embed(entry)    # pass a text column, not the whole record
  entry.update(embedding: embedding.vectors)
  puts "#{entry.terme_francais} embedding set"
end
puts "Embedding #{DictionaryEntry.count} dictionary entries is successfully completed!"

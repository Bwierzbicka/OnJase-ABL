
puts "#{DictionaryEntry.count} dictionary entries are being destroyed. Please wait."
DictionaryEntry.destroy_all
puts "Dictionary entries have been destroyed!"
puts "#{DictionaryPhrase.count} dictionary phrases are being destroyed. Please wait."
DictionaryPhrase.destroy_all
puts "Dictionary phrases have been destroyed!"
Message.destroy_all
Chat.destroy_all
UserConversationMessage.destroy_all
UserConversation.destroy_all
SavedItem.destroy_all
DeckFlashcard.destroy_all
Flashcard.destroy_all
Deck.destroy_all
Phrase.destroy_all
Word.destroy_all
User.destroy_all

user = User.create!( # user = current_user
  email: "test@example.com",
  password: "password123",
  password_confirmation: "password123",
  username: "user 1"
)

word1 = Word.create!(
  french: "maison",
  english: "house",
  definition: "A building used as a home",
  word_type: "nom"
)

word2 = Word.create!(
  french: "courir",
  english: "to run",
  definition: "To move swiftly on foot",
  word_type: "verbe"
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

deck1 = Deck.create!(name: "Basic French Vocabulary", user: user)
deck2 = Deck.create!(name: "Common French Phrases", user: user)

flashcard1 = Flashcard.create!(question: "What is the French word for 'house'?", answer: "maison", user: user)
flashcard2 = Flashcard.create!(question: "What is the French word for 'to run'?", answer: "courir", user: user)
flashcard3 = Flashcard.create!(question: "How do you say 'Hello, how are you?' in French?", answer: "Bonjour, comment ça va ?", user: user)
flashcard4 = Flashcard.create!(question: "How do you say 'I don't understand' in French?", answer: "Je ne comprends pas", user: user)

DeckFlashcard.create!(deck: deck1, flashcard: flashcard1)
DeckFlashcard.create!(deck: deck1, flashcard: flashcard2)
DeckFlashcard.create!(deck: deck2, flashcard: flashcard3)
DeckFlashcard.create!(deck: deck2, flashcard: flashcard4)

deck3 = Deck.create!(name: "Québécois Expressions", user: user2)
deck4 = Deck.create!(name: "French Verbs", user: user2)

flashcard5 = Flashcard.create!(question: "What does 'tiguidou' mean?", answer: "It's all good / Perfect", user: user2)
flashcard6 = Flashcard.create!(question: "What does 'c'est le boutte' mean?", answer: "It's the best / It's awesome", user: user2)
flashcard7 = Flashcard.create!(question: "How do you conjugate 'être' in the present tense for 'je'?", answer: "je suis", user: user2)
flashcard8 = Flashcard.create!(question: "How do you conjugate 'avoir' in the present tense for 'il/elle'?", answer: "il/elle a", user: user2)

DeckFlashcard.create!(deck: deck3, flashcard: flashcard5)
DeckFlashcard.create!(deck: deck3, flashcard: flashcard6)
DeckFlashcard.create!(deck: deck4, flashcard: flashcard7)
DeckFlashcard.create!(deck: deck4, flashcard: flashcard8)

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


# ADD LINES TO SEEDS BEFORE THIS LOGIC, IF POSSIBLE
# Logic for the Dictionary Entries from CSV starts here
require "csv"

filepath = "data/oqlf_2026-01-19.csv"

MASCULIN = /\(\s*n\.\s*m\.(?:\s*pl\.)?\s*\)/

FÉMININ = /\(\s*n\.\s*f\.(?:\s*pl\.)?\s*\)/

BOTH = /\(\s*n\.\s*m\.\s*ou\s*f\.(?:\s*pl\.)?\s*\)/

def gender(text)

  return nil if text.nil?

  markers = text.scan(/\([^)]*\)/) # ALL (...) groups → array

  marker = markers.find { |m| m !~ /\(loc\./ } # first that isn't (loc.)

  return nil unless marker

    case marker

    when BOTH then :both

    when MASCULIN then :masculin

    when FÉMININ then :féminin

    end

end

POS_PATTERNS = {

nom: /\(n\./, # (n.m. (n.f. (n.m. et f. — all just "nom"

verbe: /\(v\./,

article: /\(art\./, # didn't find any in CSV

adjectif: /\(adj\./,

pronom: /\(pron\./, # didn't find any in CSV

adverbe: /\(adv\./,

préposition: /\(prép\./,

conjonction: /\(conj\./, # didn't find any in CSV

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
puts "Dictionary entries are being generated, from the first 50 CSV entries. Please wait." # CSV.foreach(filepath).first(n) do |row|
CSV.foreach(filepath).first(50).each do |row| #replace 50 by the number we want to generate. if we want all just remove .first(50)
  g = gender(row[0])
  w = categorize(row[0])
  next if g.nil? || w.nil?
  word_entry = DictionaryEntry.create!(terme_francais: row[0], terme_anglais: row[1], definition: row[2], gender: g, word_type: w)
  puts "#{word_entry.terme_francais} was created!" # comment this out if you don't want to see the words created
end
puts "#{DictionaryEntry.count} dictionary entries were created successfully!"

# print "Should I continue with the embedding of #{DictionaryEntry.count} dictionary records? (y/n): "
# answer = gets.chomp.downcase
# exit unless answer == "y"

# # Costs .01 USD per 50, 10 USD for the whole thing, according to my maths :)
# puts "Embedding #{DictionaryEntry.count} dictionary entries are being generated. Please wait."
# DictionaryEntry.all.each do |entry|
#   str = ""
#   str.concat(entry.terme_francais, entry.terme_anglais, entry.definition, entry.gender, entry.word_type)
#   embedding = RubyLLM.embed(entry)    # pass a text column, not the whole record
#   entry.update(embedding: embedding.vectors)
#   puts "#{entry.terme_francais} embedding set"
# end
# puts "Embedding #{DictionaryEntry.count} dictionary entries is successfully completed!"

# Logic for the Dictionary Entries from CSV starts here
require "csv"

filepath2 = "data/expressions-quebecoises_20260615.csv"

puts "Dictionary phrases (there should be 93) are being generated. Please wait."
CSV.foreach(filepath2, headers: true) do |row|

  phrase_entry = DictionaryPhrase.create!(french: row[0], english: row[1])
  puts "#{phrase_entry.french} was created!" # comment this out if you don't want to see the words created
end
puts "#{DictionaryPhrase.count} dictionary phrases were created successfully!"

print "Should I continue with the embedding of #{DictionaryEntry.count} dictionary words and #{DictionaryPhrase.count} dictionary phrases? (y/n): "
answer = gets.chomp.downcase
exit unless answer == "y"

# Costs .01 USD per 50, 10 USD for the whole thing, according to my maths :)
puts "Embedding #{DictionaryEntry.count} dictionary entries are being generated. Please wait."
DictionaryEntry.all.each do |entry|
  str = ""
  str.concat(entry.terme_francais, entry.terme_anglais, entry.definition, entry.gender, entry.word_type)
  embedding = RubyLLM.embed(entry)    # pass a text column, not the whole record
  entry.update(embedding: embedding.vectors)
  puts "#{entry.terme_francais} embedding set"
end
puts "Embedding #{DictionaryEntry.count} dictionary entries is successfully completed!"

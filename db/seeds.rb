
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
  email: "eric@example.com",
  password: "password123",
  password_confirmation: "password123",
  username: "Eric"
)

arnold = User.create!( # user = current_user
  email: "arnold@gmail.com",
  password: "password123",
  password_confirmation: "password123",
  username: "Arnold"
)

arnoldTest = User.create!( # user = current_user
  email: "arnoldTest@gmail.com",
  password: "password123",
  password_confirmation: "password123",
  username: "Arnold_Test"
)



user10 = User.create!( # user = current_user
  email: "bob@example.com",
  password: "password123",
  password_confirmation: "password123",
  username: "Bobbie"
)

user11 = User.create!( # user = current_user
  email: "ania@example.com",
  password: "password123",
  password_confirmation: "password123",
  username: "Anna12"
)

user12 = User.create!( # user = current_user
  email: "MG@example.com",
  password: "password123",
  password_confirmation: "password123",
  username: "MG"
)

user13 = User.create!( # user = current_user
  email: "etienne@example.com",
  password: "password123",
  password_confirmation: "password123",
  username: "etienne"
)

user14 = User.create!( # user = current_user
  email: "kate@example.com",
  password: "password123",
  password_confirmation: "password123",
  username: "kate89"
)

user15 = User.create!( # user = current_user
  email: "bennie@example.com",
  password: "password123",
  password_confirmation: "password123",
  username: "bennie_07"
)


word1 = Word.create!(
  french: "maison",
  english: "house",
  definition: "Un bâtiment utilisé comme habitation",
  word_type: "nom"
)

word2 = Word.create!(
  french: "courir",
  english: "to run",
  definition: "Se déplacer rapidement à pied",
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

word3 = Word.create!(
  french: "chat",
  english: "cat",
  definition: "Un petit mammifère carnivore domestiqué",
  word_type: "nom",
  gender: "masculin"
)

word4 = Word.create!(
  french: "manger",
  english: "to eat",
  definition: "Consommer de la nourriture pour se nourrir",
  word_type: "verbe"
)

word5 = Word.create!(
  french: "beau",
  english: "beautiful / handsome",
  definition: "Qui possède des qualités agréables aux sens",
  word_type: "adjectif"
)

word6 = Word.create!(
  french: "dormir",
  english: "to sleep",
  definition: "Se reposer dans un état de sommeil",
  word_type: "verbe"
)

word7 = Word.create!(
  french: "eau",
  english: "water",
  definition: "Un liquide clair essentiel à la vie",
  word_type: "nom",
  gender: "féminin"
)

word8 = Word.create!(
  french: "grand",
  english: "big / tall",
  definition: "De grande taille, étendue ou intensité",
  word_type: "adjectif"
)

word9 = Word.create!(
  french: "livre",
  english: "book",
  definition: "Une œuvre écrite ou imprimée composée de pages",
  word_type: "nom",
  gender: "masculin"
)

word10 = Word.create!(
  french: "parler",
  english: "to speak",
  definition: "S'exprimer par des mots parlés",
  word_type: "verbe"
)

word11 = Word.create!(
  french: "ville",
  english: "city",
  definition: "Un grand lieu habité de façon permanente",
  word_type: "nom",
  gender: "féminin"
)

word12 = Word.create!(
  french: "apprendre",
  english: "to learn",
  definition: "Acquérir des connaissances ou une compétence par l'étude ou l'expérience",
  word_type: "verbe"
)

phrase3 = Phrase.create!(
  french: "S'il vous plaît",
  english: "Please"
)

phrase4 = Phrase.create!(
  french: "Merci beaucoup",
  english: "Thank you very much"
)

phrase5 = Phrase.create!(
  french: "De rien",
  english: "You're welcome"
)

phrase6 = Phrase.create!(
  french: "Excusez-moi",
  english: "Excuse me"
)

phrase7 = Phrase.create!(
  french: "Je m'appelle...",
  english: "My name is..."
)

phrase8 = Phrase.create!(
  french: "Parlez-vous anglais ?",
  english: "Do you speak English?"
)

phrase9 = Phrase.create!(
  french: "Je voudrais...",
  english: "I would like..."
)

phrase10 = Phrase.create!(
  french: "Où est... ?",
  english: "Where is... ?"
)

phrase11 = Phrase.create!(
  french: "Je suis désolé(e)",
  english: "I'm sorry"
)

phrase12 = Phrase.create!(
  french: "À bientôt",
  english: "See you soon"
)

SavedItem.create!(user: user, saveable: word1)
SavedItem.create!(user: user, saveable: word2)
SavedItem.create!(user: user, saveable: word3)
SavedItem.create!(user: user, saveable: word4)
SavedItem.create!(user: user, saveable: word5)
SavedItem.create!(user: user, saveable: word6)
SavedItem.create!(user: user, saveable: word7)
SavedItem.create!(user: user, saveable: word8)
SavedItem.create!(user: user, saveable: word9)
SavedItem.create!(user: user, saveable: word10)
SavedItem.create!(user: user, saveable: word11)
SavedItem.create!(user: user, saveable: word12)
SavedItem.create!(user: user, saveable: phrase1)
SavedItem.create!(user: user, saveable: phrase2)
SavedItem.create!(user: user, saveable: phrase3)
SavedItem.create!(user: user, saveable: phrase4)
SavedItem.create!(user: user, saveable: phrase5)
SavedItem.create!(user: user, saveable: phrase6)
SavedItem.create!(user: user, saveable: phrase7)
SavedItem.create!(user: user, saveable: phrase8)
SavedItem.create!(user: user, saveable: phrase9)
SavedItem.create!(user: user, saveable: phrase10)
SavedItem.create!(user: user, saveable: phrase11)
SavedItem.create!(user: user, saveable: phrase12)

user2 = User.create!(
  email: "autre@example.com",
  password: "password123",
  password_confirmation: "password123",
  username: "user 2"
)

user3 = User.create!(
  email: "b.wierzbicka90@gmail.com",
  password: "password123",
  password_confirmation: "password123",
  username: "beata-1990"
)

SavedItem.create!(user: user3, saveable: word1)
SavedItem.create!(user: user3, saveable: word2)
SavedItem.create!(user: user3, saveable: word3)
SavedItem.create!(user: user3, saveable: word4)
SavedItem.create!(user: user3, saveable: word5)
SavedItem.create!(user: user3, saveable: word6)
SavedItem.create!(user: user3, saveable: word7)
SavedItem.create!(user: user3, saveable: word8)
SavedItem.create!(user: user3, saveable: word9)
SavedItem.create!(user: user3, saveable: word10)
SavedItem.create!(user: user3, saveable: word11)
SavedItem.create!(user: user3, saveable: word12)

deck1 = Deck.create!(name: "Basic French Vocabulary", user: user)
deck2 = Deck.create!(name: "Common French Phrases", user: user2)
deck3 = Deck.create!(name: "Common French Phrases", user: user3)

flashcard1 = Flashcard.create!(question: "What is the French word for 'house'?", answer: "maison", user: user)
flashcard2 = Flashcard.create!(question: "What is the French word for 'to run'?", answer: "courir", user: user)
flashcard3 = Flashcard.create!(question: "How do you say 'Hello, how are you?' in French?", answer: "Bonjour, comment ça va ?", user: user)
flashcard4 = Flashcard.create!(question: "How do you say 'I don't understand' in French?", answer: "Je ne comprends pas", user: user)

flashcard33 = Flashcard.create!(question: "Hi, how are you?", answer: "Salut, comment ça va ?", user: user3)
flashcard44 = Flashcard.create!(question: "I am still learning French?", answer: "J'apprends encore le français", user: user3)
flashcard55 = Flashcard.create!(question: "Thank You everyone, Have a nice night", answer: "Merci tout le monde, passe une bonne soirée!", user: user3)

DeckFlashcard.create!(deck: deck1, flashcard: flashcard1)
DeckFlashcard.create!(deck: deck1, flashcard: flashcard2)
DeckFlashcard.create!(deck: deck2, flashcard: flashcard3)
DeckFlashcard.create!(deck: deck2, flashcard: flashcard4)

DeckFlashcard.create!(deck: deck3, flashcard: flashcard44)
DeckFlashcard.create!(deck: deck3, flashcard: flashcard33)
DeckFlashcard.create!(deck: deck3, flashcard: flashcard55)

deck3 = Deck.create!(name: "Québécois Expressions", user: user3)
deck4 = Deck.create!(name: "French Verbs", user: user2)

flashcard5 = Flashcard.create!(question: "What does 'tiguidou' mean?", answer: "It's all good / Perfect", user: user3)
flashcard6 = Flashcard.create!(question: "What does 'c'est le boutte' mean?", answer: "It's the best / It's awesome", user: user3)
flashcard7 = Flashcard.create!(question: "How do you conjugate 'être' in the present tense for 'je'?", answer: "je suis", user: user3)
flashcard8 = Flashcard.create!(question: "How do you conjugate 'avoir' in the present tense for 'il/elle'?", answer: "il/elle a", user: user3)

DeckFlashcard.create!(deck: deck3, flashcard: flashcard5)
DeckFlashcard.create!(deck: deck3, flashcard: flashcard6)
DeckFlashcard.create!(deck: deck4, flashcard: flashcard7)
DeckFlashcard.create!(deck: deck4, flashcard: flashcard8)

conversation = UserConversation.create!(user1: user3, user2: user2)
conversation1 = UserConversation.create!(user1: user3, user2: user10)
conversation2 = UserConversation.create!(user1: user3, user2: user11)
conversation3 = UserConversation.create!(user1: user3, user2: user12)
conversation4 = UserConversation.create!(user1: user3, user2: user13)
conversation5 = UserConversation.create!(user1: user3, user2: user14)
conversation6 = UserConversation.create!(user1: user3, user2: user15)
conversation7 = UserConversation.create!(user1: user3, user2: arnold)
conversation8 = UserConversation.create!(user1: user3, user2: arnoldTest)

UserConversationMessage.create!(
  user_conversation_id: conversation8.id,
  user_id: arnoldTest.id.to_s,
  content: "On se rencontre près du kiosque SAQ."
)

UserConversationMessage.create!(
  user_conversation_id: conversation8.id,
  user_id: user3.id.to_s,
  content: "Je suis à la grande scène, on se voit là-bas."
)

UserConversationMessage.create!(
  user_conversation_id: conversation8.id,
  user_id: arnoldTest.id.to_s,
  content: "Quoi de neuf Beata, est ce que t'as aimé le show pis la musique?"
)

UserConversationMessage.create!(
  user_conversation_id: conversation.id,
  user_id: user3.id.to_s,
  content: "Hey! How are you doing?"
)

UserConversationMessage.create!(
  user_conversation_id: conversation7.id,
  user_id: arnold.id.to_s,
  content: "On se rencontre près du kiosque SAQ."
)

UserConversationMessage.create!(
  user_conversation_id: conversation7.id,
  user_id: user3.id.to_s,
  content: "Je suis à la grande scène, on se voit là-bas."
)

UserConversationMessage.create!(
  user_conversation_id: conversation7.id,
  user_id: arnold.id.to_s,
  content: "Quoi de neuf Beata, est ce que t'as aimé le show pis la musique?"
)

UserConversationMessage.create!(
  user_conversation_id: conversation.id,
  user_id: user2.id.to_s,
  content: "Ça va bien, merci ! Et toi ?",
  translation: "I'm doing well, thanks! And you?"
)
UserConversationMessage.create!(
  user_conversation_id: conversation.id,
  user_id: user3.id.to_s,
  content: "All good! Do you want to practice some French today?"
)
UserConversationMessage.create!(
  user_conversation_id: conversation.id,
  user_id: user2.id.to_s,
  content: "Oui, bien sûr ! Commençons.",
  translation: "Yes, of course! Let's start."
)

UserConversationMessage.create!(
  user_conversation_id: conversation1.id,
  user_id: user2.id.to_s,
  content: "Ça va bien, merci ! Et toi ?"
)

UserConversationMessage.create!(
  user_conversation_id: conversation2.id,
  user_id: user10.id.to_s,
  content: "Ça te tente-tu d’aller au Piknic Électronik en fin de semaine?"
)

UserConversationMessage.create!(
  user_conversation_id: conversation3.id,
  user_id: user11.id.to_s,
  content: "Oui!"
)

UserConversationMessage.create!(
  user_conversation_id: conversation4.id,
  user_id: user12.id.to_s,
  content: "On va prendre un café?"
)

UserConversationMessage.create!(
  user_conversation_id: conversation5.id,
  user_id: user13.id.to_s,
  content: "on se voit demain"
)

UserConversationMessage.create!(
  user_conversation_id: conversation6.id,
  user_id: user14.id.to_s,
  content: "J’tripe sur cette app"
)

UserConversationMessage.create!(
  user_conversation_id: conversation1.id,
  user_id: user15.id.to_s,
  content: "parfait!"
)

chat = Chat.create!(user: user, title: "French vocabulary help")

Message.create!(chat: chat, role: "user", content: "Can you help me understand when to use 'tu' vs 'vous' in French?")
Message.create!(chat: chat, role: "assistant", content: "Of course! 'Tu' is the informal singular 'you', used with friends, family, and children. 'Vous' is the formal or plural 'you', used with strangers, authority figures, or when addressing multiple people.")
Message.create!(chat: chat, role: "user", content: "That makes sense! So I should use 'vous' when talking to my French teacher?")

SavedItem.all.each do |item|
  saveable = item.saveable
  embedding = RubyLLM.embed("#{saveable.english},#{saveable.french}")
  item.update!(embedding: embedding.vectors)
end

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

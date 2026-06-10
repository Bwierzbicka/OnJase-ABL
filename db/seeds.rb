
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

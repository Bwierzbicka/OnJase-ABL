class Message < ApplicationRecord
  after_create_commit :broadcast_append_to_chat
  belongs_to :chat
  belongs_to :tool_call, optional: true

  acts_as_message

  private

  def broadcast_append_to_chat
    broadcast_append_to chat, target: "messages", partial: "messages/message", locals: { message: self }
  end
end

class UserConversationPolicy < ApplicationPolicy
  def show?
    participant?
  end

  def destroy?
    participant?
  end

  def call_assistant?
    participant?
  end

  def call_typing_assistant?
    participant?
  end

  class Scope < ApplicationPolicy::Scope
  end

  private

  def participant?
    record.user1 == user || record.user2 == user
  end
end

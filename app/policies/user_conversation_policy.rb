class UserConversationPolicy < ApplicationPolicy
  # NOTE: Up to Pundit v2.3.1, the inheritance was declared as
  # `Scope < Scope` rather than `Scope < ApplicationPolicy::Scope`.
  # In most cases the behavior will be identical, but if updating existing
  # code, beware of possible changes to the ancestors:
  # https://gist.github.com/Burgestrand/4b4bc22f31c8a95c425fc0e30d7ef1f5

  # def index?
  #   record.user == user
  # end

  def new?
    record.user1 == user || record.user2 == user
  end

  def create?
    record.user1 == user || record.user2 == user
  end

  def show?
    record.user1 == user || record.user2 == user
  end

  def destroy?
    record.user1 == user || record.user2 == user
  end

  def call_assistant?
    record.user1 == user || record.user2 == user
  end

  def call_typing_assistant?
    record.user1 == user || record.user2 == user
  end

  class Scope < ApplicationPolicy::Scope
  end
end

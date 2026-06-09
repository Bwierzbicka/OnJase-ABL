require "test_helper"

class UserConversationMessagesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get user_conversation_messages_create_url
    assert_response :success
  end
end

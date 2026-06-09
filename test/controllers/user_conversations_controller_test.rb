require "test_helper"

class UserConversationsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get user_conversations_new_url
    assert_response :success
  end

  test "should get create" do
    get user_conversations_create_url
    assert_response :success
  end

  test "should get show" do
    get user_conversations_show_url
    assert_response :success
  end

  test "should get destroy" do
    get user_conversations_destroy_url
    assert_response :success
  end
end

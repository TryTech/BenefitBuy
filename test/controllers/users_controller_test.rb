require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end
  test "should create user" do
    assert_difference("User.count") do
      post users_url, params: { user: { email: "test@test.test", password: "password", password_confirmation: "password" } }
    end
  end
end

require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end
  test "should create user" do
    assert_difference("User.count") do
      post sign_up_url, params: { user: { email: "test@test.test", password: "password", password_confirmation: "password" } }
    end
  end

  test "should get new" do
    get sign_up_url
    assert_response :success
  end
end

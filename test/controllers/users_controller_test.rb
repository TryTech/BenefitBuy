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

  test "should not create user with invalid data" do
    assert_no_difference("User.count") do
      post sign_up_url, params: { user: { email: "a", password: "password", password_confirmation: "password" } }
    end
  end

  test "should not create user with mismatched password" do
    assert_no_difference("User.count") do
      post sign_up_url, params: { user: { email: "test@test.test", password: "password", password_confirmation: "password1" } }
    end
  end

  test "should receive confirmation email" do
    assert_difference("ActionMailer::Base.deliveries.size") do
      post sign_up_url, params: { user: { email: "a@a.a", password: "password", password_confirmation: "password" } }
    end
  end
end

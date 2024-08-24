require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "create session" do
    post login_url, params: { user: { email: @user.email, password: "password" } }
    assert_response :redirect
    assert_redirected_to root_path
  end

  test "create session and remember" do
    post login_url, params: { user: { email: @user.email, password: "password", remember_me: "1" } }
    assert_response :redirect
    assert_redirected_to root_path
    assert_not_nil cookies[:remember_token]
  end

  test "create session with unconfirmed user" do
    @user.update(confirmed_at: nil)
    post login_url, params: { user: { email: @user.email, password: "password" } }
    assert_response :redirect
    assert_redirected_to new_confirmation_path
  end

  test "create session with invalid credentials" do
    post login_url, params: { user: { email: @user.email, password: "invalid" } }
    assert_response :unprocessable_entity
  end

  test "new session" do
    get login_url
    assert_response :success
  end

  test "destroy session" do
    post login_url, params: { user: { email: @user.email, password: "password" } }
    delete logout_url
    assert_response :redirect
    assert_redirected_to root_path
  end
end

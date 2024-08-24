require "test_helper"

class PasswordsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "create password reset" do
    post passwords_url, params: { user: { email: @user.email } }
    assert_response :redirect
    assert_redirected_to root_path
  end

  test "create password reset with unconfirmed user" do
    @user.update(confirmed_at: nil)
    post passwords_url, params: { user: { email: @user.email } }
    assert_response :redirect
    assert_redirected_to new_confirmation_path
  end

  test "create password reset with invalid email" do
    post passwords_url, params: { user: { email: "invalid" } }
    assert_response :redirect
    assert_redirected_to root_path
  end

  test "edit password reset" do
    get edit_password_url(@user.signed_id(purpose: :reset_password))
    assert_response :success
  end

  test "edit password reset with unconfirmed user" do
    @user.update(confirmed_at: nil)
    get edit_password_url(@user.signed_id(purpose: :reset_password))
    assert_response :redirect
    assert_redirected_to new_confirmation_path
  end

  test "edit password reset with invalid token" do
    get edit_password_url("invalid")
    assert_response :redirect
    assert_redirected_to new_password_path
  end

  test "update password reset" do
    patch password_url(@user.signed_id(purpose: :reset_password)), params: { user: { password: "password", password_confirmation: "password" } }
    assert_response :redirect
    assert_redirected_to login_path
  end

  test "update password reset with unconfirmed user" do
    @user.update(confirmed_at: nil)
    patch password_url(@user.signed_id(purpose: :reset_password)), params: { user: { password: "password", password_confirmation: "password" } }
    assert_response :redirect
    assert_redirected_to new_confirmation_path
  end
end

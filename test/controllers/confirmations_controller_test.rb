require "test_helper"

class ConfirmationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should new confirmation" do
    get new_confirmation_url
    assert_response :success
  end

  test "should create confirmation" do
    @user.update!(confirmed_at: nil)
    assert_difference("ActionMailer::Base.deliveries.size") do
      post confirmations_url, params: { user: { email: @user.email } }
    end
  end

  test "should edit confirmation" do
    get edit_confirmation_url(confirmation_token: @user.signed_id(purpose: :confirm_email))
    assert_redirected_to root_url
  end
end

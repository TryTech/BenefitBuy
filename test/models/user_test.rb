require "test_helper"

class UserTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
  end

  test "should not save user without email" do
    @user.email = nil

    assert_not @user.save
  end

  test "should not save user with invalid email" do
    @user.email = "invalid_email"

    assert_not @user.save
  end

  test "should save user with valid email" do
    assert @user.save
  end

  test "should not save user with duplicate email" do
    user = User.new(email: @user.email)

    assert_not user.save
  end

  test "should downcase email before saving" do
    email = "email@gmail.gmail"
    user = User.new(email: email)
    user.save
    assert_equal email.downcase, user.email
  end

  test "should confirm user" do
    @user.confirm!

    assert @user.confirmed?
  end

  test "should generate confirmation token" do
    assert @user.generate_confirmation_token
  end

  test "should check if user is unconfirmed" do
    @user.confirmed_at = nil
    assert @user.unconfirmed?
  end

  test "should check if user is confirmed" do
    @user.confirm!

    assert_not @user.unconfirmed?
  end

  test "should not save user without password" do
    @user.password = nil

    assert_not @user.save
  end

  test "should send confirmation email" do
    assert @user.send_confirmation_email!
  end

  test "should have MAILER_FROM_EMAIL constant" do
    assert User::MAILER_FROM_EMAIL
  end

  test "should have CONFIRMATION_TOKEN_EXPIRATION constant" do
    assert User::CONFIRMATION_TOKEN_EXPIRATION
  end
end

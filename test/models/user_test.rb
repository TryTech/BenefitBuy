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

  test "should have PASSWORD_RESET_TOKEN_EXPIRATION constant" do
    assert User::PASSWORD_RESET_TOKEN_EXPIRATION
  end

  test "should validates unconfirmed email" do
    @user.unconfirmed_email = "invalid_email"

    assert_not @user.save
  end

  test "should before save downcase unconfirmed email" do
    email = "Teste@gmail.com"
    @user.unconfirmed_email = email
    @user.save
    assert_equal email.downcase, @user.unconfirmed_email
  end

  test "should has_many active_sessions dependent destroy" do
    assert_difference("ActiveSession.count", -1) do
      @user.destroy
    end
  end

  test "should authenticate by email and password" do
    attributes = { email: @user.email, password: "password" }
    assert User.authenticate_by(attributes)
  end

  test "should generate password reset token" do
    assert @user.generate_password_reset_token
  end

  test "should send password reset email" do
    assert @user.send_password_reset_email!
  end

  test "should not authenticate by invalid email" do
    attributes = { email: "invalid_email", password: "password" }
    assert_not User.authenticate_by(attributes)
  end

  test "should not authenticate by invalid password" do
    attributes = { email: @user.email, password: "invalid_password" }
    assert_not User.authenticate_by(attributes)
  end

  test "should confirm user with unconfirmed email" do
    @user.unconfirmed_email = "test@gmail.com"

    @user.confirm!

    assert @user.confirmed?
  end

  test "should confirmable email" do
    email = "test@gmail.com"

    @user.unconfirmed_email = email

    assert_equal email, @user.confirmable_email
  end

  test "should reconfirming" do
    email = "test@gmail.com"

    @user.unconfirmed_email = email

    assert @user.reconfirming?
  end

  test "should unconfirmed or reconfirming" do
    email = "test@gmail.com"

    @user.unconfirmed_email = email

    assert @user.unconfirmed_or_reconfirming?
  end

  test "should not unconfirmed or reconfirming" do
    assert_not @user.unconfirmed_or_reconfirming?
  end

  test "should confirmed?" do
    @user.confirm!

    assert @user.confirmed?
  end

  test "should user has many orders dependent destroy" do
    assert_difference("Order.count", -1) do
      @user.destroy
    end
  end

  test "should user has many addresses dependent destroy" do
    assert_difference("Address.count", -1) do
      @user.destroy
    end
  end

  test "should user has many products dependent destroy" do
    assert_difference("Product.count", -1) do
      @user.destroy
    end
  end
end

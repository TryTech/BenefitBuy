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
end

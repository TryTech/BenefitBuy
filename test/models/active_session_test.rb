require "test_helper"

class ActiveSessionTest < ActiveSupport::TestCase
  setup do
    @active_session = active_sessions(:one)
  end

  test "should belong to user" do
    assert_respond_to @active_session, :user
  end

  test "should have secure token" do
    assert_respond_to @active_session, :remember_token
  end
end

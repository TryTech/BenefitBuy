require "test_helper"

class ActiveSessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "destroy active session" do
    login_as(@user)

    active_session = @user.active_sessions.create

    delete active_session_url(active_session)
  end

  test "destroy all active sessions" do
    login_as(@user)

    @user.active_sessions.create
    @user.active_sessions.create

    delete destroy_all_active_sessions_url
  end
end

require "test_helper"

class UserMailerTest < ActionMailer::TestCase
  setup do
    @user = users(:one)
  end

  test "confirmation" do
    mail = UserMailer.confirmation @user, @user.generate_confirmation_token
    assert_equal I18n.t("user_mailer.confirmation.subject"), mail.subject
    assert_equal [ @user.email ], mail.to
    assert_equal [ User::MAILER_FROM_EMAIL ], mail.from
  end
end

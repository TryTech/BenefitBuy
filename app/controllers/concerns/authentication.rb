module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :current_user
    helper_method :current_user
    helper_method :user_signed_in?
  end

  def forget(user)
    cookies.delete :remember_token
    user.regenerate_remember_token
  end

  def remember(active_session)
    cookies.permanent.encrypted[:remember_token] = active_session.remember_token
  end

  def authenticate_user!
    store_location
    redirect_to login_path, alert: I18n.t("users.authentication.unauthenticated") unless user_signed_in?
  end

  def login(user)
    reset_session
    active_session = user.active_sessions.create!(user_agent: request.user_agent, ip_address: request.ip)
    session[:current_active_session_id] = active_session.id

    active_session
  end

  def forget_active_session
    cookies.delete :remember_token
  end

  def logout
    active_session = ActiveSession.find_by(id: session[:current_active_session_id])
    reset_session
    active_session&.destroy
  end

  def redirect_if_authenticated
    redirect_to root_path, alert: I18n.t("users.authentication.signed_in") if user_signed_in?
  end

  private

  def current_user
    Current.user = if session[:current_active_session_id].present?
      ActiveSession.find_by(id: session[:current_active_session_id])&.user
    elsif cookies.permanent.encrypted[:remember_token].present?
      ActiveSession.find_by(remember_token: cookies.permanent.encrypted[:remember_token])&.user
    end
  end

  def user_signed_in?
    Current.user.present?
  end

  def store_location
    session[:user_return_to] = request.original_url if request.get? && request.local?
  end
end

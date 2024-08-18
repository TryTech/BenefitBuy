class ConfirmationsController < ApplicationController
  before_action :redirect_if_authenticated, only: [ :new, :create ]

  def create
    @user = User.find_by_email(params[:user][:email].downcase)

    if @user.present? && @user.unconfirmed?
      @user.send_confirmation_email!
      redirect_to root_path, notice: I18n.t("users.confirmations.success")
    else
      redirect_to new_confirmation_path, alert: I18n.t("users.confirmations.error")
    end
  end

  def edit
    @user = User.find_signed(params[:confirmation_token], purpose: :confirm_email)

    if @user.present? && @user.unconfirmed_or_reconfirming?
      if @user.confirm!
        login @user
        redirect_to root_path, notice: I18n.t("users.confirmations.confirmed")
      else
        redirect_to new_confirmation_path, alert: I18n.t("users.confirmations.something_wrong")
      end
    else
      redirect_to new_confirmation_path, alert: I18n.t("users.confirmations.invalid")
    end
  end

  def new
    @user = User.new
  end
end

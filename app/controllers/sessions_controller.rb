class SessionsController < ApplicationController
  before_action :redirect_if_authenticated, only: [ :new, :create ]
  before_action :authenticate_user!, only: [ :destroy ]

  def create
    @user = User.authenticate_by(email: params[:user][:email].downcase, password: params[:user][:password])

    if @user
      if @user.unconfirmed?
        redirect_to new_confirmation_path, alert: I18n.t("sessions.create.unconfirmed")
      elsif @user.authenticate(params[:user][:password])
        after_login_path = session[:user_return_to] || root_path
        login @user
        remember @user if params[:user][:remember_me] == "1"
        redirect_to after_login_path, notice: I18n.t("sessions.create.notice")
      else
        flash.now[:alert] = I18n.t("sessions.create.alert")
        render :new, status: :unprocessable_entity
      end
    else
      flash.now[:alert] = I18n.t("sessions.create.alert")
      render :new, status: :unprocessable_entity
    end
  end


  def new
  end

  def destroy
    forget current_user
    logout
    redirect_to root_path, notice: I18n.t("sessions.destroy.notice")
  end
end

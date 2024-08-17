class SessionsController < ApplicationController
  before_action :redirect_if_authenticated, only: [ :new, :create ]

  def create
    @user = User.find_by(email: params[:user][:email].downcase)

    if @user
      if @user.unconfirmed?
        redirect_to new_confirmation_path, alert: I18n.t("sessions.create.unconfirmed")
      elsif @user.authenticate(params[:user][:password])
        login @user
        redirect_to root_path, notice: I18n.t("sessions.create.notice")
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
    logout
    redirect_to root_path, notice: I18n.t("sessions.destroy.notice")
  end
end

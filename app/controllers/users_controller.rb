class UsersController < ApplicationController
  before_action :redirect_if_authenticated, only: [ :new, :create ]
  before_action :authenticate_user!, only: [ :edit, :destroy, :update ]

  def create
    @user = User.new create_user_params

    if @user.save
      @user.send_confirmation_email!
      redirect_to root_path, notice: I18n.t("users.create.success")
    else
      render :new, status: :unprocessable_entity
    end
  end

  def new
    @user = User.new
  end

  def edit
    @user = current_user
    @active_sessions = @user.active_sessions.order(created_at: :desc)
  end

  def update
    @user = current_user
    @active_sessions = @user.active_sessions.order(created_at: :desc)
    if @user.authenticate(params[:user][:current_password])
      if @user.update(update_user_params)
        if params[:user][:unconfirmed_email].present?
          @user.send_confirmation_email!
          redirect_to root_path, notice: I18n.t("users.update.email_changed")
        else
          redirect_to root_path, notice: I18n.t("users.update.success")
        end
      else
        render :edit, status: :unprocessable_entity
      end
    else
      flash.now[:error] = I18n.t("users.update.invalid_password")
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    current_user.destroy
    reset_session
    redirect_to root_path, notice: I18n.t("users.destroy.success")
  end

  private

  def create_user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def update_user_params
    params.require(:user).permit(:current_password, :password, :password_confirmation, :unconfirmed_email)
  end
end

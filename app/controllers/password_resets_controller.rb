class PasswordResetsController < ApplicationController
  attr_reader :user

  before_action :find_user, :valid_user, :check_expiration,
    only: %i(edit update)

  def new; end

  def create
    @user = User.find_by email: params[:password_reset][:email].downcase

    return user_exist if user
    flash.now[:danger] = t ".notfound"
    render :new
  end

  def edit; end

  def update
    if params[:user][:password].empty?
      params_empty
    elsif user.update_attributes user_params
      update_valid
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit :password, :password_confirmation
  end

  def find_user
    @user = User.find_by email: params[:email]
  end

  def valid_user
    return if user && user.activated? && user.authenticated?(:reset, params[:id])
    flash[:danger] = t "password_resets.update.invalid"
    redirect_to root_url
  end

  def check_expiration
    return unless user.password_reset_expired?
    flash[:danger] = I18n.t "password_resets.update.expired"
    redirect_to new_password_reset_url
  end

  def user_exist
    user.create_reset_digest
    user.send_password_reset_email
    flash[:info] = t ".send"
    redirect_to root_url
  end

  def params_empty
    user.errors.add :password, t(".empty")
    render :edit
  end

  def update_valid
    log_in user
    flash[:success] = t ".success"
    user.update_attributes reset_digest: nil
    redirect_to user
  end
end

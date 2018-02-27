class UsersController < ApplicationController
  attr_reader :user

  before_action :logged_in_user, :find_user, only: %i(show edit update destroy)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: :destroy
  before_action :gender_list, only: %i(new edit update)

  def index
    @users = User.paginate page: params[:page], per_page: Settings.page.maximum
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if user.save
      log_in user
      flash[:success] = t ".welcome"
      redirect_to user
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if user.update_attributes user_params
      flash[:success] = t ".success"
      redirect_to user
    else
      render :edit
    end
  end

  def destroy
    user.destroy
    flash[:success] = t ".deleted"
    redirect_to users_url
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation, :gender, :age
  end

  def gender_list
    @genders = User.genders.map do |key, value|
      [I18n.t("users.show.#{key}"), value]
    end
  end

  def find_user
    @user = User.find_by id: params[:id]

    return if user
    flash[:danger] = I18n.t "users.show.error"
    redirect_to root_path
  end

  def logged_in_user
    return if logged_in?
    store_location
    flash[:danger] = I18n.t "users.edit.login"
    redirect_to login_url
  end

  def correct_user
    redirect_to root_url unless user.current_user? current_user
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
  end
end

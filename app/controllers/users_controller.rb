class UsersController < ApplicationController
  attr_reader :user

  before_action :gender_list, only: :new

  def new
    @user = User.new
  end

  def show
    @user = User.find_by id: params[:id]

    return if user
    flash[:danger] = t ".error"
    redirect_to root_path
  end

  def create
    @user = User.new user_params

    if user.save
      flash[:success] = t ".welcome"
      redirect_to user
    else
      render :new
    end
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
end

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include SessionsHelper

  before_action :set_locale

  class << self
    def default_url_options
      {locale: I18n.locale}
    end
  end

  def logged_in_user
    return if logged_in?
    store_location
    flash[:danger] = t "users.edit.login"
    redirect_to login_url
  end

  def find_user
    @user = User.find_by id: params[:id]

    return if user
    flash[:danger] = t "users.show.error"
    redirect_to root_path
  end

  def set_relation
    @relation = current_user.following?(user) ? find_relation : create_relation
  end

  def find_relation
    current_user.active_relationships.find_by followed_id: user.id
  end

  def create_relation
    current_user.active_relationships.build
  end

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end

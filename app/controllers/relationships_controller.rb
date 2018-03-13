class RelationshipsController < ApplicationController
  attr_reader :user
  attr_reader :relationship

  before_action :logged_in_user
  before_action :find_user, only: :index
  before_action :find_relationship, only: :destroy
  before_action :set_relation, only: %i(create destroy)

  def index
    follow_params = params[:follow]
    @title = t "follow.#{follow_params}"
    @users = user.send_method(follow_params).paginate page: params[:page]
  end

  def create
    @user = User.find_by id: params[:followed_id]
    return user_not_found unless user
    current_user.follow user
    @relation = current_user.active_relationships.find_by followed_id: user.id
    respond
  end

  def destroy
    @user = relationship.followed
    current_user.unfollow user
    @relation = current_user.active_relationships.build
    respond
  end

  private

  def respond
    respond_to do |format|
      format.html{redirect_to user}
      format.js
    end
  end

  def find_retionship
    @relationship = Relationship.find_by id: params[:id]
    return unless relationship
    flash[:danger] = ".notfound"
    redirect_to root_path
  end

  def user_not_found
    flash[:danger] = t "users.show.error"
    redirect_to root_path
  end
end

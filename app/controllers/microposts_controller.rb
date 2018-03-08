class MicropostsController < ApplicationController
  attr_reader :micropost

  before_action :logged_in_user, only: %i(create destroy)
  before_action :correct_user, :find_micropost, only: :destroy
  before_action :feed_item, only: :create

  def create
    @micropost = current_user.microposts.build micropost_params

    if micropost.save
      flash[:success] = t ".success"
      redirect_to root_url
    else
      render "static_pages/home"
    end
  end

  def destroy
    micropost.destroy
    flash[:success] = t ".delete"
    redirect_to request.referer || root_url
  end

  private

  def micropost_params
    params.require(:micropost).permit :content, :picture
  end

  def correct_user
    micropost = current_user.microposts.find_by id: params[:id]
    redirect_to root_url if micropost.blank?
  end

  def feed_item
    @feed_items = current_user.feed.paginate page: params[:page]
  end

  def find_micropost
    micropost = Micropost.find_by id: params[:id]

    return if micropost
    flash[:danger] = t "microposts.error"
    redirect_to root_url
  end
end

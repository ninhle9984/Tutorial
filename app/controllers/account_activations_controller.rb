class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by email: params[:email]

    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      activate_success user
    else
      flash[:danger] = t ".invalid"
      redirect_to root_url
    end
  end

  private

  def activate_success user
    flash[:success] = t ".valid"
    log_in user
    user.activate
    redirect_to user
  end
end

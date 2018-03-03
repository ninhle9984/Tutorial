class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: account[:email].downcase

    if user && user.authenticate(account[:password])
      authenticated user
    else
      flash.now[:danger] = t ".errors"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private

  def account
    params[:sessions]
  end

  def authenticated user
    if user.activated?
      user_activated user
    else
      user_unactivated
    end
  end

  def user_activated arg
    log_in arg
    account[:remember_me] == "1" ? remember(arg) : forget(arg)
    redirect_back_or arg
  end

  def user_unactivated
    flash[:warning] = t ".message"
    redirect_to root_url
  end
end

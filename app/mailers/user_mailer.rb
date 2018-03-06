class UserMailer < ApplicationMailer
  attr_reader :user

  def account_activation arg
    @user = arg
    mail to: user.email, subject: t(".subject")
  end

  def password_reset arg
    @user = arg
    mail to: user.email, subject: t(".subject")
  end
end

class UserMailer < ActionMailer::Base
  default from: "flirtapp@example.com"

  def signup_confirmation(user)
    @user = user
    mail to: user.email, subject: "Signup Confirmation"
  end

  def connection_email(user, newflirt)
    @user = user
    @newflirt = newflirt
    mail to: user.email, subject: "Someone flirted you back on Pairlet!"
  end

end

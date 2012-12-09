class UserMailer < ActionMailer::Base
  default from: "flirtapp@example.com"

  def signup_confirmation(user)
    @user = user
    mail to: user.email, subject: "Signup Confirmation"
  end
end

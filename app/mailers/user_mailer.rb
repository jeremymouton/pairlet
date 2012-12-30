class UserMailer < ActionMailer::Base
  default from: "flirtapp@example.com"

  def signup_confirmation(user)
    @user = user
    mail to: user.email, subject: "Signup Confirmation"
  end

  def connection_email(flirting_user, matching_user)
    @flirting_user = flirting_user
    @matching_user = matching_user

    @flirting_user_account = @flirting_user.links.first
    @flirted_user_account = @matching_user.links.first

    mail to: flirting_user.email, subject: "Someone flirted you back on Pairlet!"
  end

end

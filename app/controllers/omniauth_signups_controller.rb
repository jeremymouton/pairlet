class OmniauthSignupsController < Devise::OmniauthCallbacksController
  
  def all
    user = User.from_omniauth(request.env["omniauth.auth"])
    if user_signed_in?
      current_user.links.create_from_omniauth(env["omniauth.auth"])
      redirect_to links_path, notice: 'Account was successfully added.'
    elsif user.persisted?
      flash.notice = "Signed in!"
      sign_in_and_redirect user
    else
      redirect_to root_path
    end
  end
  alias_method :twitter, :all
  alias_method :facebook, :all

end
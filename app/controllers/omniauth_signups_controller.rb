class OmniauthSignupsController < Devise::OmniauthCallbacksController
  
  def all
    user = User.from_omniauth(request.env["omniauth.auth"])
    if user_signed_in?
      # TODO
      # Add better error handling if account handle has already been taken.
      current_user.links.create_from_omniauth(env["omniauth.auth"]) 
      redirect_to flirts_path, notice: "Account was successfully added."
    elsif user.persisted?
      sign_in_and_redirect user
      @first_name = ((current_user.links.first).name).split[0] rescue nil
      flash.notice = @first_name.nil? ? "Hi there! Welcome back." : "Welcome back #{@first_name}!"
    else
      session["devise.user_attributes"] = user.attributes
      redirect_to new_user_registration_url
    end
  end
  alias_method :twitter, :all
  alias_method :facebook, :all

end
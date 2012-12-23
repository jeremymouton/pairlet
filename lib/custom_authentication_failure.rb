class CustomAuthenticationFailure < Devise::FailureApp 
  
  protected 
    def redirect_url 
      root_path  #or whatever route in your app that points to '/' 
    end 

end 
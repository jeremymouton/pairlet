class PagesController < ApplicationController

  def index
  	if user_signed_in? 
	  redirect_to flirts_path
	end 
  end

  def about
  end

  def terms
  end
  
end

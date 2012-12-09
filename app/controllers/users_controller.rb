class UsersController < ApplicationController

  before_filter :authenticate_user!

  def mutual_flirts
    @title = "Mutual flirts"
    @users = Array.new
    current_user.flirted_users.each do |flirted|
      if current_user.mutual_flirts?(flirted)
        @users << flirted
      end
    end
    render 'relationships/mutual_flirts'
  end
  
end
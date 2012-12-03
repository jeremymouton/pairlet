class UsersController < ApplicationController

  before_filter :authenticate_user!

  def following
    @title = "Flirting..."
    @users = current_user.flirted_users
    render 'relationships/show_flirted'
  end

  # def followers
  #   @title = "Followers"
  #   @user = User.find(params[:id])
  #   @users = @user.followers.paginate(page: params[:page])
  #   render 'show_follow'
  # end

end
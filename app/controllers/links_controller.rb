class LinksController < ApplicationController

  before_filter :authenticate_user!
  respond_to :html, :json

  def index
    @links = current_user.links

    @providers = Array.new
    @links.each do |link| 
      @providers << link.provider
    end 
  end

  def create

    current_user.links.create_from_omniauth(env["omniauth.auth"])
    redirect_to links_path, notice: 'Account was successfully added.'

    # if params[:provider] == 'email' || 'phone'
    #   @link = current_user.links.create!(params[:link])
    #   if @link.valid?
    #     @link.save
    #     redirect_to links_path, notice: 'Link was successfully created.'
    #   else
    #     render action: "new"
    #   end
    # else
    #   current_user.links.create_from_omniauth(env["omniauth.auth"])
    #   redirect_to links_path, notice: 'Account was successfully added.'
    # end

  end

  def destroy
    @link = Link.find(params[:id])
    @link.destroy
    redirect_to links_path, notice: 'Account was successfully removed.'
  end
end

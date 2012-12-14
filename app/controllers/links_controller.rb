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

  def destroy
    @link = Link.find(params[:id])
    @link.destroy
    redirect_to links_path, notice: 'Account was successfully removed.'
  end
end

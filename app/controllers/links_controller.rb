class LinksController < ApplicationController

  before_filter :authenticate_user!
  respond_to :html, :json

  def index
    @links = current_user.links
  end

  def show
    @link = current_user.links.find(params[:id])
  end

  def new
    @link = Link.new
  end

  def create
    link = current_user.links.from_omniauth(env["omniauth.auth"])
    redirect_to links_path, notice: "Signed in!"
  end

  def destroy
    @link = Link.find(params[:id])
    @link.destroy
    redirect_to links_path, notice: 'Account was successfully removed.'
  end
end

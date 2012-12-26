class LinksController < ApplicationController

  before_filter :authenticate_user!
  respond_to :html, :json

  def destroy
    @link = Link.find(params[:id])
    @link.destroy
    redirect_to flirts_path, notice: 'Account was successfully removed.'
  end
  
end

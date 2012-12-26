class FlirtsController < ApplicationController

  before_filter :authenticate_user!
  respond_to :html, :json

  def index
    @flirts = current_user.flirts
    @flirt = Flirt.new

    @links = current_user.links
    @providers = Array.new
    @links.each do |link| 
      @providers << link.provider
    end 
  end

  def create
    @flirt = current_user.flirts.new(params[:flirt])

    if @flirt.valid?
      @flirt.save
      redirect_to flirts_path, notice: 'Flirt was successfully created.'
    else
      redirect_to flirts_path, alert: 'Could not add this person. Make sure the username is valid.'
    end
  end

  def destroy
    @flirt = Flirt.find(params[:id])
    @flirt.destroy
    redirect_to flirts_path, notice: 'Successfully deleted.'
  end
  
end

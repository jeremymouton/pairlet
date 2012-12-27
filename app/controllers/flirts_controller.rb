class FlirtsController < ApplicationController

  before_filter :authenticate_user!
  respond_to :html, :json

  def index
    @flirts = current_user.flirts
    @flirt = Flirt.new

    # user accounts - twitter || facebook
    @links = current_user.links
    
    # get the providers 
    @providers = Array.new 
    @links.each do |link| 
      @providers << link.provider
    end 

    # get the user's mutual flirts
    @mutual = Array.new
    current_user.flirted_users.each do |flirted|
      if current_user.mutual_flirts?(flirted)
        flirted.links.each do |link|
          @mutual << link.handle
        end
      end
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

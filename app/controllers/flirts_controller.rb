class FlirtsController < ApplicationController

  before_filter :authenticate_user!
  respond_to :html, :json

  def index
    # shorthand is not as readable IMO
    # @flirts = current_user.subscribed? ? current_user.flirts : current_user.flirts.limit(1)
    unless current_user.subscribed?
      @flirts = current_user.flirts.limit(5)
    else
      @flirts = current_user.flirts
    end

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
      redirect_to flirts_path, notice: 'Successfully added new person.'
    else
      redirect_to flirts_path, alert: "#{(@flirt.errors.full_messages.first).split.drop(1).join(' ')}"
    end
  end

  def destroy
    @flirt = Flirt.find(params[:id])
    
    # delete the flirter -> flirted relationship too 
    # if the flirt had been matched to a user
    if @flirt.matched == true
      @flirted_id = Link.where(:handle => @flirt.handle).first.user_id
      @relationship = Relationship.where(:flirter_id => current_user.id, :flirted_id => @flirted_id).first
      @relationship.destroy
    end

    @flirt.destroy
    redirect_to flirts_path, notice: "Successfully removed."
  end
  
end

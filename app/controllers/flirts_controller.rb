class FlirtsController < ApplicationController

  before_filter :authenticate_user!
  respond_to :html, :json

  def index
    @flirts = current_user.flirts
    @flirt = Flirt.new
  end

  def create
    @flirt = current_user.flirts.new(params[:flirt])

    if @flirt.valid?
      @flirt.save
      redirect_to flirts_path, notice: 'Flirt was successfully created.'
    else
      redirect_to flirts_path, alert: 'Could not add Flirt.'
    end
  end

  def destroy
    @flirt = Flirt.find(params[:id])
    @flirt.destroy
    redirect_to flirts_path, notice: 'Successfully deleted.'
  end
end

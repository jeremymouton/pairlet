class LinksController < ApplicationController

  respond_to :html, :json

  def index
    @links = current_user.links
  end

  def show
    @link = Link.find(params[:id])
  end

  def new
    @link = Link.new
  end

  def edit
    @link = Link.find(params[:id])
  end

  def create
    @link = current_user.links.create!(params[:link])

    if @link.valid?
      @link.save
      redirect_to @link, notice: 'Link was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @link = Link.find(params[:id])

    if @link.update_attributes(params[:link])
      redirect_to @link, notice: 'Link was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @link = Link.find(params[:id])
    @link.destroy
  end
end

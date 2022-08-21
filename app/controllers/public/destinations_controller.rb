class Public::DestinationsController < ApplicationController
  def index
    @destination = Destination.new
    @destinations = Destination.all(current_user)
  end

  def edit
  end

  def create
    destination = Destination.new
    destination.save
    redirect_to request.referer
  end

  def update
  end

  def destroy
  end
  
  private deatination_params
    params.require(:destination).permit(:postal_code, :address, :name)
  def
  
  end
end

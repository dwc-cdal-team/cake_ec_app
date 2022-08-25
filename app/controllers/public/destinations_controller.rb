class Public::DestinationsController < ApplicationController

  before_action :authenticate_customer!

  def index
    @destination_new = Destination.new
    @destinations = Destination.where(customer_id: current_customer.id)
  end

  def edit
    @destination = Destination.find(params[:id])
  end

  def create
    @destination_new = Destination.new(destination_params)
    @destination_new.customer_id = current_customer.id
    if @destination_new.save
      redirect_to destinations_path
    else
      @destinations = Destination.where(customer_id: current_customer.id)
      render :index
    end
  end

  def update
    @destination = Destination.find(params[:id])
    if @destination.update(destination_params)
      redirect_to destinations_path
      flash[:notice] = "編集した内容を保存しました。"
    else
      render :edit
    end
  end

  def destroy
    @destination = Destination.find(params[:id])
    @destination.destroy
    redirect_to destinations_path
  end

  private

  def destination_params
    params.require(:destination).permit(:postal_code, :address, :name)
  end
end

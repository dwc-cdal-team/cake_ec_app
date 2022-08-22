class Public::OrdersController < ApplicationController
  def new
  end

  def confirm
  end

  def complete
  end

  def create
  end

  def index
    @orders = Kaminari.paginate_array(current_customer.orders.reverse).page(params[:page]).per(10)
  end

  def show
  end
end

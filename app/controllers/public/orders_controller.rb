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
    @order = Order.find(params[:id])
    @order_items = @order.order_items
    @total = 0
    @order_items.each do |item|
      @total += ( item.price_with_tax * item.amount )
    end
  end
end

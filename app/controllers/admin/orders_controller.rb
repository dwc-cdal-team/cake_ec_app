class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @total_price = 0

    @order.order_items.each do |order_item|
      @total_price += (order_item.price_with_tax * order_item.amount)
    end
  end

  def update
  end
end

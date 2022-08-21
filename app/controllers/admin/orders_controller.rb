class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @total_price = 0

    @order.order_items.each do |order_item|
      @total_price += (order_item.price_with_tax * order_item.amount)
    end

    @destination_address = "〒" + @order.postal_code.to_s.insert(3, "-") + " " + @order.address
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_status: params[:order][:order_status])
    flash[:notice] = "注文ステータスを更新しました。"
    redirect_to admin_order_path(@order.id)
  end

end

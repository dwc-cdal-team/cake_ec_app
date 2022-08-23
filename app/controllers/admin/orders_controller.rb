class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

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

    if @order.order_status == "paid_up"
      @order.order_items.each do |order_item|
        if order_item.making_status == "unable"
          order_item.update(making_status: 1)
        end
      end
    end

    flash[:notice] = "注文ステータスを更新しました。"
    redirect_to admin_order_path(@order.id)
  end

end

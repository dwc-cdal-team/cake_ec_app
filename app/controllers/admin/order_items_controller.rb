class Admin::OrderItemsController < ApplicationController
  before_action :authenticate_admin!

  def update
    @order_item = OrderItem.find(params[:id])
    @order_item.update(making_status: params[:order_item][:making_status])

    if @order_item.making_status == "making"
      @order_item.order.update(order_status: 2)
    elsif OrderItem.where(order_id: @order_item.order_id).count == OrderItem.where(order_id: @order_item.order_id, making_status: "finish").count
      #OrderItem.where(making_status: 3).count
      @order_item.order.update(order_status: 3)
      #Order.find(id: @order_item.order_id).update(order_status: 3)
    end

    flash[:notice] = "制作ステータスを更新しました。"
    redirect_to admin_order_path(@order_item.order_id)
  end
end

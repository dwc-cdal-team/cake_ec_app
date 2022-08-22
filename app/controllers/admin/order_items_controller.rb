class Admin::OrderItemsController < ApplicationController

  def update
    @order_item = OrderItem.find(params[:id])
    @order_item.update(making_status: params[:order_item][:making_status])
    flash[:notice] = "制作ステータスを更新しました。"
    redirect_to admin_order_path(@order_item.order_id)
  end
end

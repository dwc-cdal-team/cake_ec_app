class Public::CartsController < ApplicationController

  before_action :ensure_customer

  def index
    @carts = current_customer.carts.all
    @total = @carts.inject(0) { |sum, cart| sum + cart.subtotal }
    #@cart = Cart.find(params[:id])
  end

  def update
    cart = Cart.find(params[:id])
    cart.update(cart_params)
    flash[:notice] = "カート内の商品情報が更新されました"
    redirect_to carts_path
  end

  def destroy
    cart = Cart.find(params[:id])
    cart.destroy
    flash[:notice] = "カート内の商品が削除されました"
    redirect_to carts_path
  end

  def destroy_all
    @customer = current_customer
    @customer.carts.destroy_all
    flash[:notice] = "カートを空にしました"
    redirect_to carts_path
  end

  def create
		@cart = Cart.new(cart_params)
		@cart.customer_id = current_customer.id
		@carts = current_customer.carts.all
		@carts.each do |cart|
      if cart.item_id == @cart.item_id
        new_amount = cart.amount + @cart.amount
        cart.update_attribute(:amount, new_amount)
        @cart.delete
      end
    end
    @cart.save
    flash[:notice] = "カートに商品を追加しました"
    redirect_to carts_path
  end


  private

  def cart_params
    params.require(:cart).permit(:item_id, :amount)
  end

  def ensure_customer
    redirect_to new_customer_session_path unless customer_signed_in?
  end

end

class Public::CartsController < ApplicationController

  before_action :ensure_customer
  before_action :setup_cart, only: [:update, :destroy, :destroy_all]

  def index
    @carts = current_customer.carts.all
    item = Item.findby(params[:id])

  end

  def update
    if @cart.update(amount: params[:amount].to_i)
      flash[:notice] = "カート内の商品情報が更新されました"
    else
      flash[:notice] = "カート内の商品情報の更新に失敗しました"
    end
    redirect_to carts_path
  end

  def destroy
    if @cart.destroy
      flash[:notice] = "カート内の商品が削除されました"
    else
      flash[:notice] = "削除に失敗しました"
    end
    redirect_to carts_path
  end

  def destroy_all

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
    flash[:notice] = "ご購入にはログインが必要です"
  end

  def setup_cart
    cart.customer_id = current_customer.id
    @cart = Cart.find_by(params[:customer_id])
  end

end

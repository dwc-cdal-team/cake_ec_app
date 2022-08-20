class Public::CartsController < ApplicationController

  before_action :ensure_customer
  #before_action :setup_cart, only: [:update, :destroy, :destroy_all, :create]

  def index
    @carts = current_customer.carts.all

  end

  def update
    if @cart.update(amount: params[:amount].to_i)
      flash[:notice] = 'カート内の商品情報が更新されました'
    else
      flash[:notice] = 'カート内の商品情報の更新に失敗しました'
    end
    redirect_to carts_path
  end

  def destroy
    if @cart.destroy
      flash[:notice] = 'カート内の商品が削除されました'
    else
      flash[:notice] = '削除に失敗しました'
    end
    redirect_to carts_path
  end

  def destroy_all

  end

  def create

    @cart = Cart.new(cart_params)
    if @cart.save
      redirect_to carts_path
    else
      redirect_to item_path(@cart.item_id)
    end

  end


  private

  def cart_params
    params.require(:cart).permit(:customer_id, :item_id, :amount)
  end

  def ensure_customer
    redirect_to new_customer_session_path unless customer_signed_in?
  end

# 　def setup_cart
#     cart.customer_id = current_customer.id
#     @cart = Cart.find_by(params[:customer_id])
# 　end

end

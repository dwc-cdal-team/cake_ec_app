class Public::CartsController < ApplicationController
  
  def index
    @carts = current_customer.carts
  end

  def update
    
  end

  def destroy
    
  end

  def destroy_all
    
  end

  def create
    
    @cart = Cart.new(cart_params)
    @cart.customer_id = current_customer.id
    if @cart.save
      redirect_to carts_path
    else
      @item = Item.find_by(id:@cart.item_id)
      redirect_to item_path(@item.id)
      flash[:notice] = "個数を選択して下さい"
    end
    
  end

  
  private
  
  def cart_params
    params.require(:cart).permit(:item_id, :amount)
  end
  
end

class Public::OrdersController < ApplicationController

  before_action :ensure_customer
  before_action :set_customer_date, only: [:new, :confirm]

  def new
    @order = Order.new
  end

  def confirm
    if params[:order][:address_number] == "1"
      @order = Order.new(order_params)
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = @customer_name
    elsif params[:order][:address_number] == "2"
      @order = Order.new(order_params)
      @destination = Destination.find(params[:order][:destination_id])
      @order.postal_code = @destination.postal_code
      @order.address = @destination.address
      @order.name = @destination.name
    elsif params[:order][:address_number] == "3"
      @order = Order.new(order_params)
      if @order.name == "" || @order.address == "" || @order.postal_code.length != 7
        flash[:alert] = "問題が発生しました。再度入力してください。"
        redirect_to new_order_path
      end
    else
      render :new
    end
    @carts = current_customer.carts.all
    @total = @carts.inject(0) { |sum, cart| sum + cart.subtotal }
    @order.postage = 800
    @total_payment = @total + @order.postage
  end

  def create
    carts = current_customer.carts.all
    @order = current_customer.orders.new(order_params)
    if @order.save
      carts.each do |cart|
        order_item = OrderItem.new
        order_item.order_id = @order.id
        order_item.item_id = cart.item_id
        order_item.price_with_tax = cart.item.price_with_tax
        order_item.amount = cart.amount
        order_item.save
      end
      redirect_to orders_complete_path
      carts.destroy_all
    else
      @order = Order.new(order_params)
      render :new
    end
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


  private

  def order_params
    params.require(:order).permit(:postal_code, :address, :name, :payment_method, :postage, :total_payment)
  end

  def destination_params
    params.require(:destination).permit(:customer_id, :postal_code, :address, :name)
  end

  def ensure_customer
    redirect_to new_customer_session_path unless customer_signed_in?
  end

  def set_customer_date
    @customer = current_customer
    @customer_name = @customer.last_name + " " + @customer.first_name
    @customer_address = @customer.postal_code + " " + @customer.address
  end
end

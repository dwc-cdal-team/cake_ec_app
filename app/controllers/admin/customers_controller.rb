class Admin::CustomersController < ApplicationController
  def index
    @customers = Customer.page(params[:page]).per(10)
  end

  def show
    @customer = Customer.find(params[:id])
    @custemer_name = @customer.last_name + " " + @customer.first_name
    @custemer_kana = @customer.last_name_kana + " " + @customer.first_name_kana

  end

  def edit
    @customer = Customer.find(params[:id])
    @custemer_name = @customer.last_name + " " + @customer.first_name
  end

  def update
    customer = Customer.find(params[:id])
    customer.update(customer_params)
    redirect_to admin_customer_path(customer.id)
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :email, :is_deleted)
  end
end

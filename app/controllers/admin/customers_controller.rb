class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @customers = Customer.page(params[:page]).per(10)
  end

  def show
    @customer = Customer.find(params[:id])
    @customer_name = @customer.last_name + " " + @customer.first_name
    @customer_kana = @customer.last_name_kana + " " + @customer.first_name_kana

  end

  def edit
    @customer = Customer.find(params[:id])
    @customer_name = @customer.last_name + " " + @customer.first_name
  end

  def update
    @customer = Customer.find(params[:id])
    @customer_name = @customer.last_name + " " + @customer.first_name
    if @customer.update(customer_params)
      redirect_to admin_customer_path(@customer.id)
      flash[:notice] = "編集した内容を保存しました。"
    else
      render :edit
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :email, :is_deleted)
  end
end

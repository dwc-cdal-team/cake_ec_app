class Public::CustomersController < ApplicationController
  def show
  end

  def edit
  end

  def update
  end

  def confirm
  end

  def deactivate
    @customer = Customer.find(params[:id])
    @cistomer.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行しました"
    redirect_to root_path
  end
end

class Admin::CustomersController < ApplicationController

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
       redirect_to admin_customer_path
    else
       render :edit
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name,:ootd_id, :is_deleted, :email)
  end
end

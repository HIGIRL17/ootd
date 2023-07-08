class Public::CustomersController < ApplicationController
   before_action :authenticate_customer!, only: [:edit]

  def show
    @customer = Customer.find(params[:id])
    @post = @customer.posts
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
     redirect_to customer_path(@customer.id)
    else
     render :edit
    end
  end

  def withdraw
    @customer = current_customer
    @customer.update(is_deleted: true)
    #@customer.posts.update_all(is_deleted: true)
    reset_session
    redirect_to root_path
  end

  def release
    @customer =  current_customer
    @customer.released! unless @customer.released?
    redirect_to  "/customers/#{@customer.id}/edit", notice: 'このアカウントを公開しました'
  end

  def nonrelease
    @customer =  current_customer
    @customer.nonreleased! unless @customer.nonreleased?
    redirect_to "/customers/#{@customer.id}/edit", notice: 'このアカウントを非公開にしました'
  end

  private

  def customer_params
    params.require(:customer).permit(:image, :ootd_id, :height, :gender, :name, :last_name ,:first_name, :email,:profile_image)
  end

  #params: {customer: {name: 'test', gender: 'man', .....}}
end

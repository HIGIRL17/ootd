class Public::HomesController < ApplicationController
  def top
    @tags = Tag.all
    if params[:gender].nil?
      @customers = Customer.released
    else
      @customers = Customer.where(gender: params[:gender])
    end
    @posts = Post.includes(:customer).where(customers: {is_deleted: false}).where(customer_id: @customers.ids)
  end
end

class Public::FavoritesController < ApplicationController

  def favorites
    @post = Post.find(params[:post_id])
    @favorites = @post.favorites
    @customer = @post.customer
    @customers = @post.favorites
  end

  def create
    post = Post.find(params[:post_id])
    favorite = current_customer.favorites.new(post_id: post.id)
    favorite.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    post = Post.find(params[:post_id])
    favorites = current_customer.favorites.find_by(post_id: post.id)
    favorites.destroy
    redirect_back(fallback_location: root_path)
  end
end

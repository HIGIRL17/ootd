class Public::PostsController < ApplicationController
  before_action :authenticate_customer!, only: [:new,:edit]

  def index
    @posts = Post.includes(:customer).where(customers: {is_deleted: false}).where(customer_id: current_customer.followings.ids)
    @tags = Tag.all
  end

  def new
    @post = Post.new
    @page_name = "posts"
  end

  def show
    @post = Post.find(params[:id])
    @customer = @post.customer
    @post_comment = PostComment.new
    @favorites = @post.favorites
    @tags = @post.tags.pluck(:name).join(', ')
  end

  def edit
    @post = Post.find(params[:id])
    @tags = @post.tags.pluck(:name).join(',')
  end

  def create
    @post = Post.new(post_params)
    @tags = params[:post][:tag].split(',')
    @post.customer_id = current_customer.id
    if @post.save
      @post.save_tags(@tags)
      redirect_to root_path
    else
      render :new
    end
  end

  def update
    post = Post.find(params[:id])
    @tags = params[:post][:tag].split(',')
    if post.update(post_params)
       post.update_tags(@tags)
      redirect_to post_path(post.id)
    else
      render :edit
    end
  end

  def search
    @tags = Tag.all
    @posts = Post.search(params[:keyword])
    @keyword = params[:keyword]
    render "index"
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to root_path
  end

  private

  def post_params
    params.require(:post).permit(:caption, :image,:post_images_images)
  end

end

class Public::TagsController < ApplicationController
  def show
    @tags = Tag.all
    @posts = Tag.find(params[:id]).posts
    render 'public/homes/top'
  end
end

class SiteController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post    = Post.find(params[:id])
    @comment = Comment.new(post: @post)
  end
end

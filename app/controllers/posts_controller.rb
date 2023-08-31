class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
    @comments = Comment.where(post_id: @user.posts.pluck(:id))
  end

  def show
    @user = User.find(params[:user_id])
    @comments = Comment.where(post_id: @user.posts.pluck(:id))
    @post = Post.find(params[:id])
  end
end

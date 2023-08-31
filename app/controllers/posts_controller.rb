class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
    @recent_comments_by_post = @posts.to_h { |post| [post.id, post.recent_comments] }
  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
    @recent_comments = @post.recent_comments
  end
end

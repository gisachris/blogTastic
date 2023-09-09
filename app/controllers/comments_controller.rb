class CommentsController < ApplicationController
  before_action :find_user
  before_action :find_post
  before_action :set_user_for_comment

  def index
    @post = Post.find(params[:post_id])
    @comments = @post.comments.all

    render json: @comments
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.author = @c_user
    @comment.post = @post

    if @comment.save
      flash[:notice] = 'Comment created successfully.'
    else
      render 'new'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    @post = Post.find(@comment.post_id)
    redirect_to user_post_path(current_user.id, @post.id), notice: 'Comment deleted.'
  end

  private

  def set_user_for_comment
    @c_user = User.find(params[:user_id])
  end

  def find_user
    @user = current_user
  end

  def find_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end

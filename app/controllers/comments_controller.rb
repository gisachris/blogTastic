class CommentsController < ApplicationController
  load_and_authorize_resource
  before_action :find_user
  before_action :find_post

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.author = @user
    @comment.post = @post
    if @comment.save
      flash[:notice] = 'Comment created successfully.'
      redirect_to user_post_path(@user, @post)
    else
      render 'new'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    @post = Post.find(@comment.post_id)


    @post.update(comments_counter: @post.comments_counter - 1)
    redirect_to user_post_path(current_user.id,@post.id), notice: 'Comment deleted.'
  end

  private

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

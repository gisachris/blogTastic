class PostsController < ApplicationController
  def index
    @user = current_user
    @posts = Post.includes(:author, :comments).where(author: @user).references(:author)
    @recent_comments_by_post = @posts.to_h { |post| [post.id, post.recent_comments] }
  end

  def show
    @user = current_user
    @post = Post.find(params[:id])
    @recent_comments = @post.recent_comments
    @new_comment = @post.comments.build
  end

  def new
    @user = current_user
    @post = @user.posts.build
    @post.comments_counter = 0
    @post.likes_counter = 0
  end

  def create
    @user = current_user
    @post = @user.posts.build(post_params)
    @post.comments_counter = 0
    @post.likes_counter = 0
    if @post.save
      redirect_to user_post_path(@user, @post), notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def like
    @user = current_user
    @post = Post.find(params[:id])
    if already_liked?(@user, @post)
      redirect_to user_post_path(@user, @post)
    else
      @like = @post.likes.new(author_id: @user.id, post_id: @post.id)

      if @like.save
        redirect_to user_post_path(@user, @post)
      else
        redirect_to user_posts_path(@user)
      end
    end
  end

  def unlike
    @user = current_user
    @post = Post.find(params[:id])
    @like = Like.find_by(author_id: @user.id, post_id: @post.id)

    if @like
      if @like.destroy
        redirect_to user_post_path(@user, @post), notice: 'Post unliked successfully.'
      else
        redirect_to user_post_path(@user, @post), alert: 'Error occurred while unliking the post.'
      end
    else
      redirect_to user_post_path(@user, @post), alert: 'You have not liked this post.'
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end

  def already_liked?(user, post)
    Like.exists?(author_id: user.id, post_id: post.id)
  end
end

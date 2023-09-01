class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
    @recent_comments_by_post = @posts.to_h { |post| [post.id, post.recent_comments] }

    @first_user = User.first
  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
    @recent_comments = @post.recent_comments
    @new_comment = @post.comments.build
  end

  def new
    @user = User.find(params[:user_id])
    @post = @user.posts.build
    @post.comments_counter = 0
    @post.likes_counter = 0
  end  

  # def new
  #   @post = Post.new
  #   @first_user = ApplicationController.new.current_user
  # end

  def create
    @user = User.find(params[:user_id])
    @post = @user.posts.build(post_params)
    @post.comments_counter = 0
    @post.likes_counter = 0
  
    if @post.save
      redirect_to user_post_path(@user, @post), notice: 'Post was successfully created.'
    else
      render :new
    end
  end  

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end

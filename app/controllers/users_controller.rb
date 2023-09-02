class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @first_user = ApplicationController.new.current_user
  end
end

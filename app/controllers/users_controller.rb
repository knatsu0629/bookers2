class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update]

  def index
    @users = User.all
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new    
  end

  def edit
    @user = User.find(params[:id])
    redirect_to root_path(current_user) unless current_user == @user
  end


  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
            flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user)
    else
      render :edit 
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to user_path(current_user) unless current_user == @user
  end
end


class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:index, :edit, :update]

  def index
  end 

  def new
    @user = User.new()
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to CryptMe!"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update(user_params)
      redirect_to @user
    else
      render :edit, flash[:info] = 'Looks like you are missing a few details'
    end
  end
  
  def show
  end

  private
  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :phone_number, :password_confirmation)
  end
  # Confirms the correct user.
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

end
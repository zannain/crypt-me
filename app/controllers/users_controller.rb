class UsersController < ApplicationController
before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  # before_action :correct_user,   only: [:edit, :update]
  before_action :set_user,   only: [:index, :edit, :update]

  def index
  end 

  def new
    @user = User.new()
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to root_path 
      flash.now[:success] = "Welcome to CryptMe!"
    else
      render :new
  end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to root_path
      flash[:success] = "Account Updated"
    else
      flash.now[:info] = 'Looks like you are missing a few details'
    end
  end
  
  def show
    @user = User.find(params[:id])
    @alerts = @user.alerts
  end

  private
  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :phone_number, :password_confirmation)
  end
  # # Confirms the correct user.
  # def correct_user
  #   @user = User.find(params[:id])
  #   redirect_to(root_url) unless current_user?(@user)
  # end

end
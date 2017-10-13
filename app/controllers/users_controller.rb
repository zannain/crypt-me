class UsersController < ApplicationController
  before_action :set_user

  def index
    # @user = User.new
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash.now[:success] = "Welcome to Crypt Me"
      redirect_to @user
    else
      flash.now[:warning]
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
      render :edit, notice: 'Looks like you are missing a few details'
    end
  end
  
  def show
    @user = User.find(params[:id])
  end

  private
  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :phone_number, :password_confirmation)
  end
end
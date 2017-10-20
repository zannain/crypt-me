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
    respond_to do |format|
    if @user.save
      log_in @user
      # flash[:success] = "Welcome to CryptMe!"
      format.html { redirect_to root_path }
      format.js 
    else
      format.html { render :action => 'new' }
      format.js { render :action => 'new' }
    end
  end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to root_path
    else
      # render :edit, flash[:info] = 'Looks like you are missing a few details'
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
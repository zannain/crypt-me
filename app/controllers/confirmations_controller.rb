class ConfirmationsController < ApplicationController
  def new
    @user = User.find(session[:user_id])
  end

  def create
    @user = User.find params[:user_id]
    if @user.verification_code == params[:verification_code]
      session[:authenticated] = true
      flash[:notice] = "Get woke #{@user.name}!"
      flash.now[:success] = "Welcome to CryptMe!"
      redirect_to root_path 
    else
      flash.now[:error] = "Verification code is incorrect."
      render :new
    end
  end
end
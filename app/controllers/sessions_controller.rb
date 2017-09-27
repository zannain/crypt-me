class SessionsController < ApplicationController
  # GET, creates a new session
  def new

  end
  # POST, receives session params
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy

  end

  private
  def sessions_params
    params.require(:session).permit(:email, :password)
  end
end

class SessionsController < ApplicationController
  before_action :new_user, only: [:index]

  def index
  end
  # GET, creates a new session
  def new
  end
  # POST, receives session params
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      # redirect_to user
      redirect_back_or root_path
      flash[:success]="Logged In!"
    else
      flash[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private
  def sessions_params
    params.require(:session).permit(:email, :password)
  end
  def new_user
    @user = User.new
  end
end

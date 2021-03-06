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
    respond_to do |format|
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      # redirect_to user
      
      format.html { redirect_back_or root_path }
      flash[:success]="Logged In!"
    else
      # flash[:danger] = 'Invalid email/password combination'
      format.html { render :action => 'new' }
      format.js { render :action => 'new' }
    end
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
    flash[:warning] = "Logged out"
  end

  private
  def sessions_params
    params.require(:session).permit(:email, :password)
  end
  def new_user
    @user = User.new
  end
end

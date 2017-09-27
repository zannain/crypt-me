module SessionsHelper
  # Log in the given user
  def log_in(user)
    session[:user_id] = user.id
  end
  # Returns the current logged in user if present
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  # Returns true if the user is logged in by calling the current_user method
  def logged_in?
    !current_user.nil?
  end
  
end
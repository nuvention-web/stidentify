module SessionsHelper

  def log_in!(user)
    session[:user_id] = user.id
  end
  
  def logged_in?
    session[:user_id].present?
  end

  def authenticated!
    unless logged_in?
      redirect_to new_session_path
    end
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def current_user?(user)
    @current_user == user
  end

end
class SessionsController < ApplicationController
  
  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      log_in!(user)
      redirect_to dashboard_path(user)
    else
      @message = "Sorry, either the email address or password you entered was incorrect. Try again:"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
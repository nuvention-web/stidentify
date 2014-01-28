class SessionsController < ApplicationController

  def new
  end

  def create
    user = Student.find_by(email: params[:email]) || Instructor.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      log_in!(user)
      
      if user.is_a?(Instructor)
        redirect_to instructor_path(user)
      else
        redirect_to student_path(user)
      end
    else
      redirect_to new_session_path
    end
  end

  def destroy
    session[:instructor_id] = nil
    session[:student_id] = nil
    redirect_to root_path
  end

end
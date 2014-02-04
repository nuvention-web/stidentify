class HomeController < ApplicationController

  def landing
    @initial_user = InitialUser.new
  end

  def signup
  end

  def create_user
    if params[:category] == "instructor"
      user = Instructor.new
    else
      user = Student.new
    end

    user.first_name = params[:first_name]
    user.last_name = params[:last_name]
    user.email = params[:email]
    user.password = params[:password]
    user.password_confirmation = params[:password_confirmation]
      
    if user.is_a?(Instructor) && Student.find_by(email: user.email).nil?
      if user.save
        InitialUserMailer.new_user(user).deliver
        session[:instructor_id] = user.id
        redirect_to instructor_path(user)
      else
        redirect_to signup_path
      end
    elsif Instructor.find_by(email: user.email).nil?
      if user.save
        InitialUserMailer.new_user(user).deliver
        session[:student_id] = user.id
        redirect_to student_path(user)
      else
        redirect_to signup_path
      end
    else
      redirect_to signup_path
    end      

  end

end
module SessionsHelper

  def log_in!(user)
    if user.is_a?(Instructor)
      session[:instructor_id] = user.id
    else
      session[:student_id] = user.id
    end
  end
  
  def logged_in?
    session[:instructor_id].present? || session[:student_id].present?
  end

  def authenticated!
    unless logged_in?
      redirect_to new_session_path
    end
  end

  def current_student
    @current_student ||= Student.find_by(id: session[:student_id])
  end

  def current_instructor
    @current_instructor ||= Instructor.find_by(id: session[:instructor_id])
  end

end
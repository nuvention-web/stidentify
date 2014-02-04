class InitialUserMailer < ActionMailer::Base
  default from: "The Debatable Team <team@debatable.co>"

  def signup(initial_user)
    @initial_user = initial_user
    mail(to: @initial_user.email, subject: 'Welcome to Debatable!')
  end

  def new_user(user)
    @user = user
    if @user.is_a?(Instructor)
      @path = instructor_path(@user)
    else
      @path = student_path(@user)
    end
    
    mail(to: @user.email, subject: 'Welcome to Debatable!')
  end

end
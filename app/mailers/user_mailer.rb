class UserMailer < ActionMailer::Base
  default from: "The STId Team <team@stidentify.com>"

  def signup(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to STId!')
  end

end
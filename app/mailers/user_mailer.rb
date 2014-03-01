class UserMailer < ActionMailer::Base
  default from: "The STIdentify Team <team@stidentify.com>"

  def signup(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to STIdentify')
  end

end
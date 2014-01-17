class InitialUserMailer < ActionMailer::Base
  default from: "The Debatable Team <team@debatable.co>"

  def signup(initial_user)
    @initial_user = initial_user
    mail(to: @initial_user.email, subject: 'Welcome to Debatable!')
  end

end
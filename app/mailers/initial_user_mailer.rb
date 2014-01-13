class InitialUserMailer < ActionMailer::Base
  default from: "brad@bradpuder.com"

  def signup(initial_user)
    @initial_user = initial_user
    mail(to: @initial_user.email, subject: 'Welcome to Debatable!')
  end

end
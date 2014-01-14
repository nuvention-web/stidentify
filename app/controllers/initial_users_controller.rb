class InitialUsersController < ApplicationController

  def create
    @initial_user = InitialUser.new(initial_user_params)
    if @initial_user.save
      InitialUserMailer.signup(@initial_user).deliver
    else
      render 'home/landing'
    end
  end

  private

  def initial_user_params
    params.require(:initial_user).permit(:name, :email, :category)
  end

end
class InitialUsersController < ApplicationController

  def create
    @initial_user = InitialUser.new(initial_user_params)
    @initial_user.category = "debater" if @initial_user.category.nil?
    @initial_user.name = "no_name" if @initial_user.name.nil?
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
class InitialUsersController < ApplicationController

  def create
    @initial_user = InitialUser.create(initial_user_params)
  end

  private

  def initial_user_params
    params.require(:initial_user).permit(:name, :email, :category)
  end

end
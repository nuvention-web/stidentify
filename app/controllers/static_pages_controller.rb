class StaticPagesController < ApplicationController
  def home
  end

  def resources
  end
end

class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    params = user_params
    @user = User.new(first_name: params[:first_name], last_name: params[:last_name], email: params[:email])
    @user.over_18 = ( params[:over_18] == "1" )
    @user.password = params[:password]
    @user.password_confirmation = params[:password_confirmation]

    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      redirect_to new_user_path, notice: "Invalid sign up. Check your email address and/or password."
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :password, :password_confirmation, :email, :over_18)
  end

end
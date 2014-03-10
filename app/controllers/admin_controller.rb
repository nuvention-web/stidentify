class AdminController < ApplicationController
  
  def sign_in
  end

  def cms
    if params[:password] == "passw0rd"
      @users = User.all
      render :cms
    else
      flash.now[:alert] = "Invalid Password!"
      redirect_to admin_path
    end
  end

end
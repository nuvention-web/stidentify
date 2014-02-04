class AdminController < ApplicationController
  
  def sign_in
  end

  def cms
    if params[:password] == "passw0rd"
      @users = InitialUser.all
      render :cms
    else
      flash.now[:alert] = "Invalid Password!"
      redirect_to admin_path
    end
  end

end
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

    @user.stid = User.assign_stid

    encoded_stid = { stid: @user.stid }
    encoded_stid = Base64.encode64(encoded_stid.to_json).delete("\n")

    response = HTTParty.post(
      "https://api.truevault.com/v1/vaults/#{ENV['TV_VAULT_ID']}/documents",
      basic_auth: {username: ENV['TV_API_KEY']},
      body: {
        document: encoded_stid,
        schema_id: ENV['TV_SCHEMA_ID']
      }
    )

    binding.pry

    @user.document_id = response["document_id"]

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
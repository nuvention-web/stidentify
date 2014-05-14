class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    params = user_params
    @user = User.new(first_name: params[:first_name], last_name: params[:last_name], email: params[:email])
    # @user = User.new(first_name: params[:first_name], last_name: "CHANGE ME", email: params[:email])
    # @user.over_18 = ( params[:over_18] == "1" )
    @user.password = "changeme123"
    @user.password_confirmation = "changeme123"
    # @user.password = params[:password]
    # @user.password_confirmation = params[:password_confirmation]

    @user.stid = User.assign_stid

    encoded_stid = { stid: @user.stid }
    encoded_stid = Base64.encode64(encoded_stid.to_json).delete("\n")

    response = HTTParty.post(
      "https://api.truevault.com/v1/vaults/#{ENV['TV_VAULT_ID']}/documents",
      basic_auth: {username: ENV['TV_API_KEY']},
      body: {
        document: encoded_stid
      }
    )

    # binding.pry

    puts response
    puts response
    puts response
    puts response["document_id"]
    puts response["document_id"]
    puts response["document_id"]

    @user.document_id = response["document_id"]

    if @user.save
      # UserMailer.signup(@user).deliver
      # session[:user_id] = @user.id
      # redirect_to user_path(@user)
      redirect_to thanks_path
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

  def compare
    @current_user = current_user
  end

  def create_compare
    user2 = User.find_by(stid: params[:stid].downcase)

    if user2.nil?
      redirect_to compare_user_path(current_user)
    else
      @status = current_user.compare_with(user2)

      render :results
    end
  end

  def results
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :password, :password_confirmation, :email, :over_18)
  end

end
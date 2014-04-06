class Api::SessionsController < ApplicationController

  skip_before_action :verify_authenticity_token
  respond_to :json

  def create
    user = User.find_by(email: params["email"])

    if user && user.authenticate(params[:password])
      api_key = ApiKey.create
      api_key.user_id = user.id
      api_key.save
      render json: {access_token: api_key.access_token, expires_at: api_key.expires_at, user_id: user.id, response: "success"}
    else
      render json: {response: "invalid"}
    end
  end

end
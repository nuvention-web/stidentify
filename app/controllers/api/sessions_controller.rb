class Api::SessionsController < ApplicationController

  skip_before_action :verify_authenticity_token
  before_action :cors_preflight_check
  after_action :cors_set_access_control_headers
  respond_to :json

  def create
    puts params
    user = User.find_by(email: params["email"])

    if user && user.authenticate(params[:password])
      api_key = ApiKey.create
      api_key.user_id = user.id
      api_key.save
      render json: {access_token: api_key.access_token, expires_at: api_key.expires_at, user_id: user.id, response: "success", first_name: user.first_name}
    else
      render json: {response: "invalid"}
    end
  end


  private

  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
    headers['Access-Control-Request-Method'] = '*'
    headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
    headers['Access-Control-Max-Age'] = "1728000"
  end

  def cors_preflight_check
    if request.method == :options
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
      headers['Access-Control-Request-Method'] = '*'
      headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
      headers['Access-Control-Max-Age'] = '1728000'
      render :text => '', :content_type => 'text/plain'
    end
  end
 

end
class Api::MatchesController < ApplicationController

  skip_before_action :verify_authenticity_token
  before_action :cors_preflight_check, :restrict_access
  after_action :cors_set_access_control_headers
  respond_to :json

def new
  #takes stid and compares user_id of access_token with stid, returns json results object
  if logged_in? 
    other_user = User.find_by(stid: params["stid"])

    unless other_user.nil?
      status = current_user.compare_with(other_user)
      render json: {status: status, response: "success"}
    else
      render json: {response: "invalid stid"}
    end
  else
    render json: {response: "invalid credentials"}
  end
end

private

def restrict_access
  session[:user_id] = ApiKey.find_by(access_token: params[:access_token]).user_id
end

end
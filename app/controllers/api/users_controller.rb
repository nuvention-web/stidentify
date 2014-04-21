class Api::UsersController < ApplicationController

  skip_before_action :verify_authenticity_token
  before_action :cors_preflight_check, #:restrict_access
  after_action :cors_set_access_control_headers
  respond_to :json

def create
  #takes stid and compares user_id of access_token with stid, returns json results object
  firstName: [insert name],
  lastName: [insert name,
  password: [password],
  passwordConfirmation: [password again],
  email: [email address],



  user = User.new(first_name: params["firstName"], last_name: params["lastName"], email: params["email"])
  user.password = params["password"]
  user.password_confirmation = params["passwordConfirmation"]

  if user.save
    api_key = ApiKey.create
    api_key.user_id = user.id
    api_key.save
    render json: 
      {
        response: "success",
        error: "none",
        access_token: api_key.access_token,
        first_name: user.first_name
      }
  else
    render json:
      {
        response: "success",
        error: "error"
      }
  end
end

private

# def restrict_access
#   session[:user_id] = ApiKey.find_by(access_token: params[:access_token]).user_id
# end

end
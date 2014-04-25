class Api::UsersController < ApplicationController

  skip_before_action :verify_authenticity_token
  before_action :cors_preflight_check #:restrict_access
  after_action :cors_set_access_control_headers
  respond_to :json

def create
  #takes stid and compares user_id of access_token with stid, returns json results object

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

def tests
  puts params["access_token"]
  api_key = ApiKey.find_by(access_token: params[:access_token])
  puts api_key


  if api_key.nil?
    render json: { response: "invalid" }
  else
    user = User.find(api_key.user_id)
    document_id = user.document_id

    params.keys.each do |k|
      if k.include?("Result")
        params[k] = true if params[k] == "true"
        params[k] = false if params[k] == "false"
      end
    end


    test_results = {
      chlamydia_result: params["chlamydiaResult"], 
      gonorrhea_result: params["gonorrheaResult"],
      hepatitis_b_result: params["hepatitisBResult"],
      hepatitis_c_result: params["hepatitisCResult"],
      herpes_1_result: params["herpes1Result"],
      herpes_2_result: params["herpes2Result"],
      hiv_result: params["hivResult"],
      syphilis_result: params["syphilisResult"]
    }

    puts test_results

    test_results = Base64.encode64(test_results.to_json).delete("\n")

    response = HTTParty.put(
      "https://api.truevault.com/v1/vaults/#{ENV['TV_VAULT_ID']}/documents/#{document_id}",
      basic_auth: { username: ENV['TV_API_KEY'] },
      body: { document: test_results }
    )

    response = JSON.parse(Base64.decode64(response))

    puts response
    puts "break"
    puts response.to_s


    render json: {
      response: "success",
      tv: response.to_s
    }

  end

end







private

# def restrict_access
#   session[:user_id] = ApiKey.find_by(access_token: params[:access_token]).user_id
# end

end
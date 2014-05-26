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
 

  user.stid = User.assign_stid

  encoded_stid = { stid: user.stid }
  encoded_stid = Base64.encode64(encoded_stid.to_json).delete("\n")

  response = HTTParty.post(
    "https://api.truevault.com/v1/vaults/#{ENV['TV_VAULT_ID']}/documents",
    basic_auth: {username: ENV['TV_API_KEY']},
    body: {
      document: encoded_stid
    }
  )

  # binding.pry

  user.document_id = response["document_id"]

  puts user

  if user.save!
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

def add_results
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
        params[k] = nil if params[k] == "null"
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

    # response = JSON.parse(Base64.decode64(response))

    puts response
    puts "break"
    puts response.to_s

    test_results["response"] = "success"


    render json: test_results
  end

  def current_results
    api_key = ApiKey.find_by(access_token: params[:access_token])

    if api_key.nil?
      render json: { response: "invalid" }
    else
      user = User.find(api_key.user_id)
      document_id = user.document_id

      response = HTTParty.get(
        "https://api.truevault.com/v1/vaults/#{ENV['TV_VAULT_ID']}/documents/#{document_id}",
        basic_auth: { username: ENV['TV_API_KEY'] }
      )

      response = JSON.parse(Base64.decode64(response))

      render json: { response: "sucess",
        "chlamydia_result"=> response["chlamydia_result"],
        "gonorrhea_result"=> response["gonorrhea_result"],
        "hepatitis_b_result"=> response["hepatitis_b_result"],
        "hepatitis_c_result"=> response["hepatitis_c_result"],
        "herpes_1_result"=> response["herpes_1_result"],
        "herpes_2_result"=> response["herpes_2_result"],
        "hiv_result"=> response["hiv_result"],
        "syphilis_result"=> response["syphilis_result"]
      }

    end
  end

  def info
    api_key = ApiKey.find_by(access_token: params[:access_token])

    if api_key.nil?
      render json: { response: "invalid" }
    else
      user = User.find(api_key.user_id)

      render json: { response: "sucess",
        first_name: user.first_name,
        last_name: user.last_name,
        email: user.email
      }
    end
  end

  def update_info
    api_key = ApiKey.find_by(access_token: params[:access_token])

    if api_key.nil?
      render json: { response: "invalid" }
    else
      user = User.find(api_key.user_id)
      user.update!(first_name: params["firstName"], last_name: params["lastName"], email: params["email"])
      user.password = params["password"]
      user.password_confirmation = params["passwordConfirmation"]

      render json: { response: "sucess",
        first_name: user.first_name,
        last_name: user.last_name,
        email: user.email
      }
    end
  end

end







private

# def restrict_access
#   session[:user_id] = ApiKey.find_by(access_token: params[:access_token]).user_id
# end

end
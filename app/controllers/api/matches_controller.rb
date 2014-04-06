class Api::MatchesController < ApplicationController

before_filter :restrict_access
respond_to :json

def new
  #takes stid and compares user_id of access_token with stid, returns json results object
end

private

def restrict_access
  authenticate_or_request_with_http_token do |token, options|
    ApiKey.exists?(access_token: token)
  end
end

end
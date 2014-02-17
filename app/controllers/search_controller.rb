class SearchController < ApplicationController

  def new
  end

  def create
    location = params[:location].gsub(" ", "+")
    geocode_response = HTTParty.get(
      "http://maps.googleapis.com/maps/api/geocode/json?sensor=false&address=#{location}"
    )

    miles = params[:radius].split(" ").first.to_i
    radius = miles * 1609

    @latlng = geocode_response["results"][0]["geometry"]["location"]
    location = "#{@latlng['lat']},#{@latlng['lng']}"

    @places_response = HTTParty.get(
      "https://maps.googleapis.com/maps/api/place/nearbysearch/json?sensor=false&location=#{location}&radius=#{radius}&keyword=sexual+clinic&rankby=prominence&key=AIzaSyCjW847ACznKi7BuzYi_snkU5DeZFRfr3k"
    )["results"].to_json

    render :results
  end

  def results
  end

end
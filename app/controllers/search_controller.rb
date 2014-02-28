class SearchController < ApplicationController

  def new
  end

  def create
    latlng = params[:info].split(")").first.delete("(").split(", ")
    radius = params[:info].split(")").last
    miles = radius.split(" ").first.to_i
    radius = miles * 1609

    places_response = HTTParty.get(
      "https://maps.googleapis.com/maps/api/place/nearbysearch/json?sensor=false&location=#{latlng.first},#{latlng.last}&radius=#{radius}&keyword=sexual+clinic&rankby=prominence&key=AIzaSyCjW847ACznKi7BuzYi_snkU5DeZFRfr3k"
    )["results"]

    @places = []

    places_response.each do |place|

      response = HTTParty.get("https://maps.googleapis.com/maps/api/place/details/json?reference=#{place["reference"]}&sensor=false&key=AIzaSyCjW847ACznKi7BuzYi_snkU5DeZFRfr3k")
      
      @places << {phone: response["result"]["formatted_phone_number"],
                  name: response["result"]["name"],
                  website: response["result"]["website"],
                  address: response["result"]["formatted_address"].split(",").first,
                  city: response["result"]["formatted_address"].split(", ")[1] + ", " + response["result"]["formatted_address"].split(", ")[2] ,
                  lat: place["geometry"]["location"]["lat"],
                  lng: place["geometry"]["location"]["lng"]
                }
    end

    respond_to do |format|
      format.js { render :json => @places}
    end

  end

  def results
    @location = params[:location].split(" ").join("+")

    # geocode_response = HTTParty.get(
    #   "http://maps.googleapis.com/maps/api/geocode/json?sensor=false&address=#{location}"
    # )

    # miles = params[:radius].split(" ").first.to_i
    # radius = miles * 1609

    # @latlng = geocode_response["results"][0]["geometry"]["location"]
    # location = "#{@latlng['lat']},#{@latlng['lng']}"

    # @places_response = HTTParty.get(
    #   "https://maps.googleapis.com/maps/api/place/nearbysearch/json?sensor=false&location=#{location}&radius=#{radius}&keyword=sexual+clinic&rankby=prominence&key=AIzaSyCjW847ACznKi7BuzYi_snkU5DeZFRfr3k"
    # )["results"].to_json

    render :results
  end

end
module ApplicationHelper

	def tv_date(date)
	end

	def radians(deg)
      pi = Math::PI
      deg.to_f * pi / 180.0
    end

    #latlng is user's latitude and longitude



    def distance(latlng, lat, lng)
      ( 6371.0 * Math.acos( Math.cos( radians(latlng.first) ) * Math.cos( radians( lat ) ) * Math.cos( radians( lng ) - radians(latlng.last) ) + Math.sin( radians(latlng.first) ) * Math.sin( radians( lat ) ) ) )
    end


end

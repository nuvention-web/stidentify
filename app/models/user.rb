class User < ActiveRecord::Base

 
  validates_presence_of :email, :first_name
  validates_uniqueness_of :email, :stid

  has_secure_password

  def self.assign_stid
  	stid = User.generate_stid

    until User.find_by(stid: stid).nil?
  	  stid = User.generate_stid
  	end

	 stid
  end

  def self.generate_stid
  	SecureRandom.hex
  end

  def compare_with(user)

  	#GET user1 data
  	user1_response = HTTParty.get(
  		"https://api.truevault.com/v1/vaults/#{ENV['TV_VAULT_ID']}/documents/#{self.document_id}",
  		basic_auth: { username: ENV['TV_API_KEY']}
  	)

  	user1 = JSON.parse(Base64.decode64(user1_response))

  	#GET user2 data
  	user2_response = HTTParty.get(
  		"https://api.truevault.com/v1/vaults/#{ENV['TV_VAULT_ID']}/documents/#{user.document_id}",
  		basic_auth: { username: ENV['TV_API_KEY']}
  	)

  	user2 = JSON.parse(Base64.decode64(user2_response))

  	#logic for caution (number of keys and therefore tests is the same)

	user1_keys = user1.keys.select { |key| !(key.include?("trich")) && !(key.include?("hpv")) }

	user2_keys = user2.keys.select { |key| !(key.include?("trich")) && !(key.include?("hpv")) }

	if (user1_keys.count != 8 || user2_keys.count != 8)
		status = "caution"
	end

  	#logic for nonmatch (at least one result doesn't match)

  	user1.keys.each do |key|
  		unless key.include?("trich") || key.include?("hpv")
	  		if key.include?("result")
	  			if user2[key].nil? && status != "nonmatch"
	  				status = "caution"
	  			elsif user1[key] != user2[key]
	  				status = "nonmatch"
	  			end
	  		end
	  	end
  	end
    

    # user2.keys.each do |key|
    #   unless key.include?("trich") || key.include?("hpv")
    #     if key.include?("result")
    #       if user1[key].nil? && status != "nonmatch"
    #         status = "caution"
    #       elsif user1[key] != user2[key]
    #         status = "nonmatch"
    #       end
    #     end
    #   end
    # end

  	if status != "caution" && status != "nonmatch"
  		status = "match"
  	end

  	status

  end

end
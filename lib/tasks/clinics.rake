namespace :clinics do
  task :import => :environment do

    clinics = File.read("#{Rails.root}/db/clinics.txt")

      clinics.encode!('UTF-16', 'UTF-8', :invalid => :replace, :replace => '')
      clinics.encode!('UTF-8', 'UTF-16')
      clinics = clinics.split("\r")

      clinic = clinics[0].split(",")
      
      Clinic.create(
        name: clinic[0],
        address: clinic[1],
        phone: clinic[2],
        website: clinics[3],
        fees: clinics[4],
        walk_in_hours: clinics[5] 
      )
      

    binding.pry
  end
end

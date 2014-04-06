class CreateClinics < ActiveRecord::Migration
  def change
    drop_table :clinics
    create_table :clinics do |t|
    	t.string :name
    	t.string :address
    	t.string :phone
    	t.string :website
    	t.string :fees
    	t.string :hours
    	t.string :lat
    	t.string :lng
    end
  end
end



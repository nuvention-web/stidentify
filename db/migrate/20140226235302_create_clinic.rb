class CreateClinic < ActiveRecord::Migration
  def change
    create_table :clinics do |t|
      t.string :name
      t.string :address
      t.string :website
      t.string :phone
      t.string :fees
      t.string :walk_in_hours
      t.float :latitude
      t.float :longitude
    end
  end
end

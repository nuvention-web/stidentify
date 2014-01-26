class CreateWorkshops < ActiveRecord::Migration
  def change
    create_table :workshops do |t|
      t.belongs_to :instructor
      t.string :name, null: false
      t.text :about, null: false
    end
  end
end

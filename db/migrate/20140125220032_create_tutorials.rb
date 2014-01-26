class CreateTutorials < ActiveRecord::Migration
  def change
    create_table :tutorials do |t|
      t.belongs_to :student
      t.belongs_to :instructor
      t.text :about
    end
  end
end

class CreateInstructors < ActiveRecord::Migration
  def change
    create_table :instructors do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.text :about_me
      t.string :password_digest, null: false
      t.belongs_to :school
    end
  end
end

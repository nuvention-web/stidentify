class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.string :password_digest, null: false
      t.text :about_me
      t.belongs_to :school
    end
  end
end

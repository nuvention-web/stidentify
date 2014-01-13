class CreateInitialUsersAgain < ActiveRecord::Migration
  def change
    drop_table :initial_users
    
    create_table :initial_users do |t|
      t.string :category, null: false
      t.string :name, null: false
      t.string :email, null: false
    end
  end
end

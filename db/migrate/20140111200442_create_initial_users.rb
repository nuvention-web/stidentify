class CreateInitialUsers < ActiveRecord::Migration
  def change
    create_table :initial_users do |t|
      t.string :type, null: false
      t.string :name, null: false
      t.string :email, null: false
    end
  end
end

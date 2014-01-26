class CreateSlots < ActiveRecord::Migration
  def change
    create_table :slots do |t|
      t.datetime :start, null: false
      t.datetime :finish, null: false
    end
  end
end

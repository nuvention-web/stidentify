class Create < ActiveRecord::Migration
  def change
    create_table :api_keys do |t|
      t.string :access_token
      t.integer :user_id
      t.datetime :expires_at
    end
  end
end

class Add < ActiveRecord::Migration
  def change
  	add_column :users, :stid, :string
  end
end

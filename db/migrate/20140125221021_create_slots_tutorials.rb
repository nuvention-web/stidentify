class CreateSlotsTutorials < ActiveRecord::Migration
  def change
    create_table :slots_tutorials do |t|
      t.belongs_to :slot
      t.belongs_to :tutorial
    end
  end
end

class CreateSlotsWorkshops < ActiveRecord::Migration
  def change
    create_table :slots_workshops do |t|
      t.belongs_to :slot
      t.belongs_to :workshop
    end
  end
end

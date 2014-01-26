class DropInstructorsSlots < ActiveRecord::Migration
  def change
    drop_table :instructors_slots
  end
end

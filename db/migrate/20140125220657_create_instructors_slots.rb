class CreateInstructorsSlots < ActiveRecord::Migration
  def change
    create_table :instructors_slots do |t|
      t.belongs_to :instructor
      t.belongs_to :slot
    end
  end
end

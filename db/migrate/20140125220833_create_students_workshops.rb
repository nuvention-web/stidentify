class CreateStudentsWorkshops < ActiveRecord::Migration
  def change
    create_table :students_workshops do |t|
      t.belongs_to :student
      t.belongs_to :workshop
    end
  end
end

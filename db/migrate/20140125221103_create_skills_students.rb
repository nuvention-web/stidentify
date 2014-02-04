class CreateSkillsStudents < ActiveRecord::Migration
  def change
    create_table :skills_students do |t|
      t.belongs_to :skill
      t.belongs_to :student
    end
  end
end

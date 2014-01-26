class ChangeInstructorsSkills < ActiveRecord::Migration
  def change
    add_column :instructors_skills, :instructor_id, :integer
    add_column :instructors_skills, :skill_id, :integer
  end
end

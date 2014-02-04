class AlterInstructorsSkills < ActiveRecord::Migration
  def change
    drop_table :instructors_skills

    create_table :instructors_skills do |t|
      t.belongs_to :instructor
      t.belongs_to :skill
    end
  end
end

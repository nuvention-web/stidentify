class CreateInstructorsSkills < ActiveRecord::Migration
  def change
    create_table :instructors_skills do |t|
      t.belongs_to :instructor
      t.belongs_to :skill
    end
  end
end

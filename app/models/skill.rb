class Skill < ActiveRecord::Base

  has_and_belongs_to_many :instructors
  has_and_belongs_to_many :students

end
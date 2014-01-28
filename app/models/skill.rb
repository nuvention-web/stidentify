class Skill < ActiveRecord::Base

  has_and_belongs_to_many :instructors
  has_and_belongs_to_many :students

  validates_presence_of :name
  validates_uniqueness_of :name

end
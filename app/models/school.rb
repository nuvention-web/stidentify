class School < ActiveRecord::Base

  has_many :instructors
  has_many :students

  validates_presence_of :name
  validates_uniqueness_of :name

end
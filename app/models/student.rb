class Student < ActiveRecord::Base

  has_and_belongs_to_many :skills
  belongs_to :school
  has_many :tutorials
  has_and_belongs_to_many :workshops

end
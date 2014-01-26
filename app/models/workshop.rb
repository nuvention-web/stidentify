class Workshop < ActiveRecord::Base

  has_and_belongs_to_many :students
  belongs_to :instructor
  has_and_belongs_to_many :slots

end
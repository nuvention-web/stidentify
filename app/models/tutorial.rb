class Tutorial < ActiveRecord::Base

  has_and_belongs_to_many :slots
  belongs_to :student
  belongs_to :instructor

end
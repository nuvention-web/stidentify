class Slot < ActiveRecord::Base

  has_and_belongs_to_many :workshops
  has_and_belongs_to_many :tutorials

end
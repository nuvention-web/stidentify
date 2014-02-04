class Slot < ActiveRecord::Base

  has_and_belongs_to_many :workshops
  has_and_belongs_to_many :tutorials

  validates_presence_of :start, :finish
  validates_uniqueness_of :start, :finish

end
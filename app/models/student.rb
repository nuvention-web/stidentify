class Student < ActiveRecord::Base

  has_and_belongs_to_many :skills
  belongs_to :school
  has_many :tutorials
  has_and_belongs_to_many :workshops

  has_secure_password

  validates_presence_of :first_name, :last_name, :email, :password_digest

  validates_uniqueness_of :email


end
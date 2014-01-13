class InitialUser < ActiveRecord::Base

  validates_presence_of :email
  validates_presence_of :name
  validates_presence_of :category

  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create

end
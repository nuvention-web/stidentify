require 'faker'

FactoryGirl.define do
  factory :student do
    name { Faker::Name.last_name + " High School" }
  end
end
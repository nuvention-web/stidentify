require 'faker'

FactoryGirl.define do
  factory :instructor do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    password 'passw0rd'
    password_confirmation 'passw0rd'
    email { Faker::Internet.email }


  end
end
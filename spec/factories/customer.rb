FactoryGirl.define do
  factory :user do
    password  { Faker::Internet.password }
    email     { Faker::Internet.email }
  end
end

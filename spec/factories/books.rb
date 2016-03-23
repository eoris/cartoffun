FactoryGirl.define do
  factory :book do
    title             { Faker::Book.title }
    description       { Faker::Lorem.paragraph }
    price             { Faker::Commerce.price }
  end
end

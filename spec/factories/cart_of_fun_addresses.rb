FactoryGirl.define do
  factory :cart_of_fun_address, class: 'CartOfFun::Address' do
    firstname { Faker::Name.first_name }
    lastname  { Faker::Name.last_name }
    address   { Faker::Address.street_address }
    zipcode   { Faker::Number.number(6) }
    city      { Faker::Address.city }
    country_id{ Faker::Number.between(1, 251) }
    phone     { Faker::PhoneNumber.phone_number }

    factory :billing_address, class: 'CartOfFun::BillingAddress' do
    end

    factory :shipping_address, class: 'CartOfFun::ShippingAddress' do
    end
  end
end

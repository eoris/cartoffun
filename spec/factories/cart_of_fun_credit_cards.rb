FactoryGirl.define do
  factory :cart_of_fun_credit_card, class: 'CartOfFun::CreditCard' do
    number           { Faker::Number.number(16) }
    cvv              { Faker::Number.number(3) }
    expiration_month { Faker::Business.credit_card_expiry_date.month }
    expiration_year  { Faker::Business.credit_card_expiry_date.year }
  end
end

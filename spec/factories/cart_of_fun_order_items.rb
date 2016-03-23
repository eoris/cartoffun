FactoryGirl.define do
  factory :cart_of_fun_order_item, class: 'CartOfFun::OrderItem' do
    price    { Faker::Commerce.price }
    quantity { Faker::Number.digit }
  end
end

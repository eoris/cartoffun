FactoryGirl.define do
  factory :cart_of_fun_order, class: 'CartOfFun::Order' do
    total_price    { Faker::Commerce.price }
    completed_date { Faker::Date.forward(23) }
    state          "delivered"
  end
end

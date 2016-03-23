FactoryGirl.define do
  factory :cart_of_fun_country, class: 'CartOfFun::Country' do
    name { Faker::Address.country }
  end
end

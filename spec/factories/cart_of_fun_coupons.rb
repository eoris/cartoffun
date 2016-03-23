FactoryGirl.define do
  factory :cart_of_fun_coupon, class: 'CartOfFun::Coupon' do
    code "1111"
    discount 0.5
  end
end

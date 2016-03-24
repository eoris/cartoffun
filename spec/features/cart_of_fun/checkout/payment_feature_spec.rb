require 'rails_helper'

RSpec.describe "payment", type: :feature do

  let(:customer) { create(:user) }
  let(:country)  { create(:cart_of_fun_country) }
  let(:order)    { create(:cart_of_fun_order, state: 'in_progress', customer: customer,
                          billing_address: create(:billing_address),
                          shipping_address: create(:shipping_address),
                          delivery: create(:cart_of_fun_delivery)) }

  context 'customer signed in' do
    before do
      allow_any_instance_of(CartOfFun::BillingAddress).to receive_message_chain(:country, :name).and_return(country)
      allow_any_instance_of(CartOfFun::ShippingAddress).to receive_message_chain(:country, :name).and_return(country)
    end

    scenario 'checkout payment' do
      login_as(customer, scope: :customer)
      visit cart_of_fun.payment_order_checkout_path(order)
      expect(page).to have_link I18n.t('cart_of_fun.checkout.address')
      expect(page).to have_link I18n.t('cart_of_fun.checkout.delivery')
      expect(page).to have_link I18n.t('cart_of_fun.checkout.payment')
      expect(page).to have_content I18n.t('cart_of_fun.checkout.payment')
      within('.new_credit_card') do
        fill_in 'credit_card[number]', with: Faker::Number.number(16)
        select '1', from: 'credit_card[expiration_month]'
        select '2033', from: 'credit_card[expiration_year]'
        fill_in 'credit_card[cvv]', with: Faker::Number.number(3)
      end
      click_button I18n.t('cart_of_fun.checkout.save')
      expect(page).to have_content I18n.t('cart_of_fun.checkout.confirm')
      expect(page).to have_link I18n.t('cart_of_fun.checkout.confirm')
    end
  end
end

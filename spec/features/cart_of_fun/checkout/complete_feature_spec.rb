require 'rails_helper'

RSpec.describe "complete", type: :feature do

  let(:customer) { create(:user) }
  let(:country)  { create(:cart_of_fun_country) }
  let(:order)    { create(:cart_of_fun_order, state: 'in_progress', customer: customer,
                          billing_address: create(:billing_address),
                          shipping_address: create(:shipping_address),
                          delivery: create(:cart_of_fun_delivery),
                          credit_card: create(:cart_of_fun_credit_card)) }

  context 'customer signed in' do
    before do
      allow_any_instance_of(CartOfFun::BillingAddress).to receive_message_chain(:country, :name).and_return(country)
      allow_any_instance_of(CartOfFun::ShippingAddress).to receive_message_chain(:country, :name).and_return(country)
    end

    scenario 'checkout complete' do
      login_as(customer, scope: :customer)
      visit cart_of_fun.order_checkout_path(order)
      expect(page).to have_link I18n.t('cart_of_fun.checkout.address')
      expect(page).to have_link I18n.t('cart_of_fun.checkout.delivery')
      expect(page).to have_link I18n.t('cart_of_fun.checkout.payment')
      expect(page).to have_link I18n.t('cart_of_fun.checkout.confirm')
      expect(page).to have_content I18n.t('cart_of_fun.checkout.confirm')
      click_button I18n.t('cart_of_fun.checkout.place_order')
      expect(page).to have_content I18n.t('cart_of_fun.checkout.back_to_store')
    end
  end
end

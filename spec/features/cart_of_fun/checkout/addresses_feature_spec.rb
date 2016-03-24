require 'rails_helper'

RSpec.describe "addresses", type: :feature, js: true do

  let(:customer) { create(:user) }
  let(:order) { create(:cart_of_fun_order, customer: customer, state: 'in_progress') }

  context 'customer signed in' do
    scenario 'checkout addresses' do
      country = create(:cart_of_fun_country)
      delivery = create_list(:cart_of_fun_delivery, 3)
      login_as(customer, scope: :customer)
      visit cart_of_fun.addresses_order_checkout_path(order)
      expect(page).to have_content(I18n.t('cart_of_fun.checkout.billing_address'))
      expect(page).to have_content(I18n.t('cart_of_fun.checkout.shipping_address'))
      within(".billing") do
        fill_in 'Firstname', with: Faker::Name.first_name
        fill_in 'Lastname', with: Faker::Name.last_name
        fill_in 'Address', with: Faker::Address.street_address
        fill_in 'City', with: Faker::Address.city
        select country.name, from: 'billing_address[country_id]'
        fill_in 'Zipcode', with: Faker::Number.number(6)
        fill_in 'Phone', with: Faker::PhoneNumber.phone_number
      end
      check 'shipping-checkbox'
      click_button I18n.t('cart_of_fun.checkout.save')
      expect(page).to have_content I18n.t('cart_of_fun.checkout.delivery')
      expect(page).to have_content I18n.t('cart_of_fun.checkout.shipping')
    end
  end
end

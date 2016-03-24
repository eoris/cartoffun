require 'rails_helper'

RSpec.describe "delivery", type: :feature do

  let(:customer)   { create(:user) }
  let(:order)      { create(:cart_of_fun_order, state: 'in_progress', customer: customer,
                            billing_address: create(:billing_address),
                            shipping_address: create(:shipping_address)) }

  context 'customer signed in' do
    before do
      @deliveries = create_list(:cart_of_fun_delivery, 3)
    end

    scenario 'checkout delivery' do
      login_as(customer, scope: :customer)
      visit cart_of_fun.delivery_order_checkout_path(order)
      expect(page).to have_link I18n.t('cart_of_fun.checkout.address')
      expect(page).to have_link I18n.t('cart_of_fun.checkout.delivery')
      expect(page).to have_content I18n.t('cart_of_fun.checkout.delivery')
      expect(page).to have_content I18n.t('cart_of_fun.checkout.shipping')
      choose "order_delivery_id_#{@deliveries.last.id}"
      expect(find("#order_delivery_id_#{@deliveries.last.id}")).to be_checked
      click_button I18n.t('cart_of_fun.checkout.save')
      expect(page).to have_content I18n.t('cart_of_fun.checkout.payment')
    end
  end
end

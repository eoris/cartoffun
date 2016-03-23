require 'rails_helper'

module CartOfFun
  RSpec.describe Order, type: :model do
    it { is_expected.to have_db_column(:total_price) }
    it { is_expected.to have_db_column(:completed_date) }
    it { is_expected.to have_db_column(:state) }
    it { is_expected.to have_db_column(:customer_id) }

    it { is_expected.to belong_to(:customer) }
    it { is_expected.to have_one(:credit_card) }
    it { is_expected.to have_one(:billing_address) }
    it { is_expected.to have_one(:shipping_address) }

    it { is_expected.to validate_presence_of(:total_price) }
    it { is_expected.to validate_presence_of(:completed_date) }
    it { is_expected.to validate_presence_of(:state) }

    describe 'aasm state' do
      before(:each) {@order = Order.new}

      it 'transitions from in_progress to in_queue' do
        allow_any_instance_of(Order).to receive(:place_order).and_return(true)
        expect(@order).to transition_from(:in_progress).to(:in_queue).on_event(:place)
        expect(@order).not_to transition_from(:in_progress).to(:in_delivery).on_event(:place)
      end

      it 'transitions from in_queue to in_delivery' do
        expect(@order).to transition_from(:in_queue).to(:in_delivery).on_event(:processed)
        expect(@order).not_to transition_from(:in_queue).to(:delivered).on_event(:processed)
      end

      it 'transitions from in_queue to canceled' do
        expect(@order).to transition_from(:in_queue).to(:canceled).on_event(:cancel)
        expect(@order).not_to transition_from(:in_queue).to(:delivered).on_event(:cancel)
      end

      it 'transitions from in_delivery to canceled' do
        expect(@order).to transition_from(:in_delivery).to(:canceled).on_event(:cancel)
        expect(@order).not_to transition_from(:in_delivery).to(:delivered).on_event(:cancel)
      end
    end

    context '.state_enum' do
      it 'return state, except in_progress' do
        order = create(:cart_of_fun_order)
        expect(order.state_enum).to match_array(['in_queue', 'in_delivery', 'delivered', 'canceled'])
      end
    end

    context '#place_order' do
      before(:each) do
        @delivery = create(:cart_of_fun_delivery, price: 7)
        @order = build(:cart_of_fun_order, total_price: 10, delivery_id: @delivery.id)
        @order.place_order
      end

      it 'build order completed date' do
        expect(@order.completed_date.strftime('%Y-%m-%d')).to eq(Time.now.strftime('%Y-%m-%d'))
      end

      it 'build order total price' do
        expect(@order.total_price).to eq(17)
      end
    end
  end
end

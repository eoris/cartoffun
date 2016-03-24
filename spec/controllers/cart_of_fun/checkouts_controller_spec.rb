require 'rails_helper'

module CartOfFun
  RSpec.describe CheckoutsController, type: :controller do
    routes { CartOfFun::Engine.routes }

    let(:customer) { create(:user) }
    let(:order)    { create(:cart_of_fun_order, state: 'in_progress', customer_id: customer.id) }
    let(:delivery) { create(:cart_of_fun_delivery) }

    it { is_expected.to use_before_action(:find_order) }
    it { is_expected.to use_before_action(:order_state_check) }
    it { is_expected.to use_before_action(:addresses_init) }
    it { is_expected.to use_before_action(:find_or_init_credit_card) }

    describe "GET #addresses" do
      context "when order has not in_progress state" do
        before do
          sign_in customer
          allow_any_instance_of(Order).to receive(:in_progress?).and_return(false)
          get :addresses, order_id: order.id
        end

        it { is_expected.to redirect_to(main_app.root_path) }
      end

      context "when customer signed in" do
        before do
          sign_in customer
          get :addresses, order_id: order.id
        end

        it { is_expected.to render_template :addresses }
        it { is_expected.to respond_with(200) }
      end
    end

    describe "PATCH #update_addresses" do
      context "when order has not in_progress state" do
        before do
          sign_in customer
          order = create(:cart_of_fun_order, state: 'in_delivery', customer_id: customer.id)
          patch :update_addresses, order_id: order.id
        end

        it { is_expected.to redirect_to(main_app.root_path) }
      end

      context "when customer signed in" do
        before do
          sign_in customer
          patch :update_addresses, order_id: order.id, billing_address: attributes_for(:cart_of_fun_address), shipping_address: attributes_for(:cart_of_fun_address)
        end

        it { is_expected.to redirect_to(delivery_order_checkout_path) }
        it { is_expected.to respond_with(302) }
      end

      context 'when addresses params is invalid' do
        before do
          sign_in customer
          patch :update_addresses, order_id: order.id, billing_address: attributes_for(:cart_of_fun_address, firstname: nil), shipping_address: attributes_for(:cart_of_fun_address)
        end

        it { is_expected.to render_template :addresses }
      end
    end

    describe "GET #delivery" do
      context "when order has not in_progress state" do
        before do
          sign_in customer
          allow_any_instance_of(Order).to receive(:in_progress?).and_return(false)
          get :delivery, order_id: order.id
        end

        it { is_expected.to redirect_to(main_app.root_path) }
      end

      context "when order has no billing or shipping addresses" do
        before do
          sign_in customer
          allow_any_instance_of(Order).to receive_message_chain(:billing_address, :nil?).and_return(true)
          allow_any_instance_of(Order).to receive_message_chain(:shipping_address, :nil?).and_return(true)
          get :delivery, order_id: order.id
        end

        it { is_expected.to redirect_to(addresses_order_checkout_path) }
      end

      context "when customer signed in" do
        before do
          sign_in customer
          allow_any_instance_of(Order).to receive_message_chain(:billing_address, :nil?).and_return(false)
          allow_any_instance_of(Order).to receive_message_chain(:shipping_address, :nil?).and_return(false)
          get :delivery, order_id: order.id
        end

        it { is_expected.to render_template :delivery }
        it { is_expected.to respond_with(200) }
      end
    end

    describe "PATCH #update_delivery" do
      context "when order has not in_progress state" do
        before do
          sign_in customer
          allow_any_instance_of(Order).to receive(:in_progress?).and_return(false)
          patch :update_delivery, order_id: order.id
        end

        it { is_expected.to redirect_to(main_app.root_path) }
      end

      context "when customer signed in" do
        before do
          sign_in customer
          patch :update_delivery, order_id: order.id, order: {delivery_id: delivery.id}
        end

        it { is_expected.to redirect_to(payment_order_checkout_path) }
        it { is_expected.to respond_with(302) }
      end
    end

    describe "GET #payment" do
      context "when order has not in_progress state" do
        before do
          sign_in customer
          allow_any_instance_of(Order).to receive(:in_progress?).and_return(false)
          get :payment, order_id: order.id
        end

        it { is_expected.to redirect_to(main_app.root_path) }
      end

      context "when order has no delivery" do
        before do
          sign_in customer
          allow_any_instance_of(Order).to receive_message_chain(:delivery, :nil?).and_return(true)
          get :payment, order_id: order.id
        end

        it { is_expected.to redirect_to(delivery_order_checkout_path) }
      end

      context "when customer signed in" do
        before do
          sign_in customer
          allow_any_instance_of(Order).to receive_message_chain(:delivery, :nil?).and_return(false)
          get :payment, order_id: order.id
        end

        it { is_expected.to render_template :payment }
        it { is_expected.to respond_with(200) }
      end
    end

    describe "PATCH #update_payment" do
      context "when order has not in_progress state" do
        before do
          sign_in customer
          allow_any_instance_of(Order).to receive(:in_progress?).and_return(false)
          patch :update_payment, order_id: order.id
        end

        it { is_expected.to redirect_to(main_app.root_path) }
      end

      context "when customer signed in" do
        before do
          sign_in customer
          patch :update_payment, order_id: order.id, credit_card: attributes_for(:cart_of_fun_credit_card)
        end

        it { is_expected.to redirect_to(confirm_order_checkout_path) }
        it { is_expected.to respond_with(302) }
      end

      context 'when payment params is invalid' do
        before do
          sign_in customer
          patch :update_payment, order_id: order.id, credit_card: attributes_for(:cart_of_fun_credit_card, cvv: nil)
        end

        it { is_expected.to render_template :payment }
      end
    end

    describe "GET #confirm" do
      context "when order has not in_progress state" do
        before do
          sign_in customer
          allow_any_instance_of(Order).to receive(:in_progress?).and_return(false)
          get :confirm, order_id: order.id
        end

        it { is_expected.to redirect_to(main_app.root_path) }
      end

      context "when order has no credit card" do
        before do
          sign_in customer
          allow_any_instance_of(Order).to receive_message_chain(:credit_card, :nil?).and_return(true)
          get :confirm, order_id: order.id
        end

        it { is_expected.to redirect_to(payment_order_checkout_path) }
      end

      context "when customer signed in" do
        before do
          sign_in customer
          allow_any_instance_of(Order).to receive_message_chain(:credit_card, :nil?).and_return(false)
          get :confirm, order_id: order.id
        end

        it { is_expected.to render_template :confirm }
        it { is_expected.to respond_with(200) }
      end
    end

    describe "POST #place" do
      context "when order has not in_progress state" do
        before do
          sign_in customer
          allow_any_instance_of(Order).to receive(:in_progress?).and_return(false)
          post :place, order_id: order.id
        end

        it { is_expected.to redirect_to(main_app.root_path) }
      end

      context "when customer signed in" do
        before do
          sign_in customer
          allow_any_instance_of(Order).to receive(:place!).and_return(true)
          post :place, order_id: order.id
        end

        it { is_expected.to redirect_to(order_checkout_path) }
        it { is_expected.to respond_with(302) }
      end

      context "when order not saved" do
        before do
          sign_in customer
          allow_any_instance_of(Order).to receive(:place!).and_return(false)
          post :place, order_id: order.id
        end

        it { is_expected.to render_template(:confirm) }
      end
    end

    describe "GET #show" do
      context "when order has not in_queue state" do
        before do
          sign_in customer
          allow_any_instance_of(Order).to receive(:in_queue?).and_return(false)
          get :show, order_id: order.id
        end

        it { is_expected.to redirect_to(confirm_order_checkout_path) }
      end
    end
  end
end

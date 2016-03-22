require_dependency "cart_of_fun/application_controller"

module CartOfFun
  class CheckoutsController < ApplicationController
    before_action :authenticate_customer!
    before_action :find_order
    before_action :set_customer
    before_action :order_state_check, except: [:show]
    before_action :addresses_init, only: [:addresses, :update_addresses]
    before_action :find_or_init_credit_card, only: [:payment, :update_payment]

    def addresses
    end

    def update_addresses
      _shipping_params = params[:shipping_as_billing] ? billing_params : shipping_params
      if @billing_address.update(billing_params) && @shipping_address.update(_shipping_params)
        redirect_to delivery_order_checkout_path
      else
        render 'addresses'
      end
    end

    def delivery
      if @order.billing_address.nil? || @order.shipping_address.nil?
        redirect_to addresses_order_checkout_path
      else
        @deliveries = Delivery.all
      end
    end

    def update_delivery
      if Delivery.find(delivery_params[:delivery_id])
        @order.update(delivery_params)
        redirect_to payment_order_checkout_path
      end
    end

    def payment
      redirect_to delivery_order_checkout_path if @order.delivery.nil?
    end

    def update_payment
      if @credit_card.update(payment_params)
        redirect_to confirm_order_checkout_path
      else
        render 'payment'
      end
    end

    def confirm
      redirect_to payment_order_checkout_path if @order.credit_card.nil?
    end

    def place
      if @order.place!
        redirect_to order_checkout_path
      else
        render 'confirm'
      end
    end

    def show
      redirect_to confirm_order_checkout_path unless @order.in_queue?
    end

    private

    def find_order
      @order = Order.find(params[:order_id])
    end

    def find_or_init_credit_card
      @credit_card = CreditCard.find_or_initialize_by(order_id: @order.id)
    end

    def order_state_check
      redirect_to root_path unless @order.in_progress?
    end

    def addresses_init
      @countries = Country.all
      if @order.shipping_address.nil? || @order.billing_address.nil?
        @billing_address = BillingAddress.build_order_address(@customer, @order)
        @shipping_address = ShippingAddress.build_order_address(@customer, @order)
      else
        @billing_address = BillingAddress.find_or_initialize_by(order_id: @order.id)
        @shipping_address = ShippingAddress.find_or_initialize_by(order_id: @order.id)
      end
    end

    def billing_params
      params.require(:billing_address).permit(:firstname, :lastname,
                                              :address, :city, :country_id,
                                              :country, :zipcode, :phone)
    end

    def shipping_params
      params.require(:shipping_address).permit(:firstname, :lastname,
                                               :address, :city, :country_id,
                                               :country, :zipcode, :phone)
    end

    def delivery_params
      params.fetch(:order, {}).permit(:delivery_id)
    end

    def payment_params
      params.require(:credit_card).permit(:expiration_month, :number,
                                          :expiration_year, :cvv)
    end
  end
end

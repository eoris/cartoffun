require_dependency "cart_of_fun/application_controller"

module CartOfFun
  class CartsController < ApplicationController

    def show
      @cart = cart.session
      @subtotal = cart.subtotal
    end

    def update
      session[:discount] = cart.update_cart(params)
      redirect_to cart_path
    end

    def add_item
      cart.add_item_to_cart(cart_params)
      redirect_to cart_path
    end

    def remove_item
      cart.remove_item_from_cart(params[:item_id])
      redirect_to cart_path
    end

    def clear
      clear_session
      redirect_to cart_path
    end

    def checkout
      @order = cart.build_order(current_customer)
      if !cart.session.empty? && @order.save
        clear_session
        redirect_to addresses_order_checkout_path(@order)
      else
        redirect_to cart_path
      end
    end

    private

    def clear_session
      session[:cart] = nil
      session[:discount] = nil
    end

    def cart
      Cart.new(session[:cart] ||= {}, session[:discount] ||= 1)
    end

    def cart_params
      params.require(:product).permit(:product_id, :quantity)
    end
  end
end

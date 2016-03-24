require_dependency "cart_of_fun/application_controller"

module CartOfFun
  class OrdersController < ApplicationController
    def index
      @orders = current_customer.orders
    end

    def show
      @order = Order.find(params[:id])
    end
  end
end

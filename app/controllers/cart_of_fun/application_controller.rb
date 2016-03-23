module CartOfFun
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    CUSTOMERS.each do |customer|
      alias_method :current_customer, "current_#{customer.underscore}".to_sym
      alias_method :authenticate_customer!, "authenticate_#{customer.underscore}!"
    end

  end
end

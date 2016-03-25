module CartOfFun
  class ApplicationController < ::ApplicationController
    protect_from_forgery with: :exception

    CUSTOMERS.each do |customer|
      if Warden
        alias_method :current_customer, "current_#{customer.underscore}".to_sym
      end
    end

  end
end

module CartOfFun
  module ActsAsCartOfFun
    extend ActiveSupport::Concern

    module ClassMethods
      def acts_as_customer
        class_eval do
          has_many :orders, class_name: 'CartOfFun::Order',
                            dependent: :destroy, as: :customer
          has_many :credit_card, class_name: 'CartOfFun::CreditCard',
                                dependent: :destroy, as: :customer
          has_one  :shipping_address, class_name: 'CartOfFun::Address',
                                dependent: :destroy, as: :customer
          has_one  :billing_address, class_name: 'CartOfFun::Address',
                                dependent: :destroy, as: :customer
        end
      end

      def acts_as_product
        PRODUCTS.push(self.name).uniq!

        class_eval do
          has_many :order_items, class_name: 'CartOfFun::OrderItem',
                                 dependent: :destroy, as: :product
        end
      end
    end
  end
end

ActiveRecord::Base.send(:include, CartOfFun::ActsAsCartOfFun)

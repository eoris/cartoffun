module CartOfFun
  class OrderItem < ActiveRecord::Base
    belongs_to :product, polymorphic: true
    belongs_to :order

    validates :price, :quantity, presence: true
  end
end

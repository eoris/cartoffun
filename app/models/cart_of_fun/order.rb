module CartOfFun
  class Order < ActiveRecord::Base
    include AASM
    belongs_to :customer, polymorphic: true
    belongs_to :delivery
    has_many :order_items
    has_one :credit_card
    has_one :billing_address
    has_one :shipping_address

    validates :total_price, :completed_date, :state, presence: true

    aasm column: :state do
      state :in_progress, initial: true
      state :in_queue
      state :in_delivery
      state :delivered
      state :canceled

      event :place, before: :place_order do
        transitions from: :in_progress, to: :in_queue
      end

      event :processed do
        transitions from: :in_queue, to: :in_delivery
      end

      event :delivered do
        transitions from: :in_delivery, to: :delivered
      end

      event :cancel do
        transitions from: [:in_queue, :in_delivery], to: :canceled
      end
    end

    def state_enum
      ['in_queue', 'in_delivery', 'delivered', 'canceled']
    end

    def place_order
      if self.total_price && self.delivery.price
        self.completed_date = Time.now
        self.total_price += self.delivery.price
      end
    end
  end
end

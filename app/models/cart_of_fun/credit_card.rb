module CartOfFun
  class CreditCard < ActiveRecord::Base
    belongs_to :customer, polymorphic: true

    validates :number, :cvv, :expiration_month, :expiration_year, presence: true
    validates_length_of :number, is: 16
    validates_length_of :cvv, is: 3
    validates_numericality_of :cvv
    validates_numericality_of :number
  end
end

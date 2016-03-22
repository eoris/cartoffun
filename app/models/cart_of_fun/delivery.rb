module CartOfFun
  class Delivery < ActiveRecord::Base
    has_many :orders

    validates :title, :price, presence: true
    validates_numericality_of :price
  end
end

require 'rails_helper'

module CartOfFun
  RSpec.describe OrderItem, type: :model do
    it { is_expected.to have_db_column(:price) }
    it { is_expected.to have_db_column(:quantity) }
    it { is_expected.to have_db_column(:product_id) }
    it { is_expected.to have_db_column(:product_type) }
    it { is_expected.to have_db_column(:order_id) }

    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_presence_of(:quantity) }

    it { is_expected.to belong_to(:product) }
    it { is_expected.to belong_to(:order) }
  end
end

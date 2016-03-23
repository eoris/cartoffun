require 'rails_helper'

module CartOfFun
  RSpec.describe Coupon, type: :model do
    it { is_expected.to have_db_column(:code) }
    it { is_expected.to have_db_column(:discount) }

    it { is_expected.to validate_uniqueness_of(:code) }
  end
end

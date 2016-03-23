require 'rails_helper'

module CartOfFun
  RSpec.describe Delivery, type: :model do
    it { is_expected.to have_db_column(:title) }
    it { is_expected.to have_db_column(:price) }

    it { is_expected.to have_many(:orders) }

    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:price) }
  end
end

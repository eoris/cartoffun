require 'rails_helper'

module CartOfFun
  RSpec.describe Country, type: :model do
    it { is_expected.to have_db_column(:name) }

    it { is_expected.to have_many(:addresses)}

    it { is_expected.to validate_presence_of(:name) }
  end
end

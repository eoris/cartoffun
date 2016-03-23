require 'rails_helper'

module CartOfFun
  RSpec.describe CreditCard, type: :model do
    it { is_expected.to have_db_column(:number) }
    it { is_expected.to have_db_column(:cvv) }
    it { is_expected.to have_db_column(:expiration_month) }
    it { is_expected.to have_db_column(:expiration_year) }

    it { is_expected.to validate_presence_of(:number) }
    it { is_expected.to validate_presence_of(:cvv) }
    it { is_expected.to validate_presence_of(:expiration_month) }
    it { is_expected.to validate_presence_of(:expiration_year) }

    it { is_expected.to belong_to(:customer) }
  end
end

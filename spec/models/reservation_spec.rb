require 'rails_helper'

RSpec.describe Reservation, type: :model do
  context "associations" do
    it { is_expected.to belong_to(:table) }
    it { is_expected.to belong_to(:restaurant) }
  end

  context "validations" do
    it { is_expected.to validate_presence_of(:owner_name) }
    it { is_expected.to validate_presence_of(:owner_phone_number) }

    it { is_expected.to validate_presence_of(:start_datetime) }
  end
end

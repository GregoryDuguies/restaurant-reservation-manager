require 'rails_helper'

RSpec.describe Reservation, type: :model do
  context "factory_bot" do
    it "creates a valid object"
  end

  context "associations" do
    it { is_expected.to belong_to(:restaurant) }

    it { is_expected.to have_many(:reservation_tables) }
  end

  context "validations" do
    it { is_expected.to validate_presence_of(:owner_name) }
    it { is_expected.to validate_presence_of(:owner_phone_number) }

    it { is_expected.to validate_presence_of(:start_datetime) }
    it { is_expected.to validate_presence_of(:end_datetime) }

    it { is_expected.to validate_presence_of(:total_guests) }
  end

  describe "#allocate_tables_v1" do
    pending
  end
end

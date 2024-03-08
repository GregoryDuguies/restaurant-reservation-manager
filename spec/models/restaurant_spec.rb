require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  context "associations" do
    it { is_expected.to have_many(:tables) }
    it { is_expected.to have_many(:reservations) }
  end

  context "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:capacity) }
  end

  describe "#capacity_at_datetime" do
    pending
  end

  describe "#max_availability_within_span" do
    pending
  end
end

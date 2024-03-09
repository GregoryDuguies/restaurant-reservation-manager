require 'rails_helper'

RSpec.describe ReservationTable, type: :model do
  context "associations" do
    it { is_expected.to belong_to(:table) }
    it { is_expected.to belong_to(:reservation) }
  end
end

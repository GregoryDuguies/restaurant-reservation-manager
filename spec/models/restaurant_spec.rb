require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  context "associations" do
    it { is_expected.to have_many(:tables) }
  end

  context "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:capacity) }
  end
end

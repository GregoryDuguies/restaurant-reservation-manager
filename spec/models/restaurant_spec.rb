require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  context "associations" do
  end

  context "validations" do
    it { is_expected.to validate_presence_of(:name) }
  end
end

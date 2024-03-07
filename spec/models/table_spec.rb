require 'rails_helper'

RSpec.describe Table, type: :model do
  context "associations" do
    it { is_expected.to belong_to(:restaurant) }
  end

  context "validations" do
    it { is_expected.to validate_presence_of(:number) }
  end
end

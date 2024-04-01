require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  context "factory_bot" do
    it "creates a valid object"
  end

  context "associations" do
    it { is_expected.to have_many(:tables) }
    it { is_expected.to have_many(:reservations) }
  end

  context "validations" do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe "#capacity" do
    let!(:restaurant_1) { FactoryBot.create(:restaurant) }
    let!(:restaurant_2) { FactoryBot.create(:restaurant) }

    let!(:table_1) { FactoryBot.create(:table, restaurant: restaurant_1) }
    let!(:table_2) { FactoryBot.create(:table, restaurant: restaurant_1) }
    let!(:table_3) { FactoryBot.create(:table, restaurant: restaurant_1) }

    let!(:table_4) { FactoryBot.create(:table, restaurant: restaurant_2) }

    it 'returns the sum of all related tables capacity' do
      expect(restaurant_1.capacity).to eq(table_1.capacity + table_2.capacity + table_3.capacity)
      expect(restaurant_2.capacity).to eq(table_4.capacity)
    end
  end

  describe "#capacity_at_datetime" do
    pending
  end

  describe "#available_tables_at_datetime" do
    pending
  end

  describe "#max_availability_within_span" do
    pending
  end
end

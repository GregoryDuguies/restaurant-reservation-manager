require 'rails_helper'

describe Resources::Reservation::API do
# describe do
  context 'GET /reservations/' do
    it 'returns all reservations' do
      restaurant = FactoryBot.create(:restaurant)
      table = FactoryBot.create(:table, restaurant: restaurant)

      reservation = FactoryBot.create(:reservation, table: table, restaurant: restaurant)

      get "/reservations", as: :json
      expect(response.body).to eq [reservation].to_json
    end
  end

  context 'GET /reservations/:id' do
    it 'returns a reservation' do
      restaurant = FactoryBot.create(:restaurant)
      table = FactoryBot.create(:table, restaurant: restaurant)

      reservation = FactoryBot.create(:reservation, table: table, restaurant: restaurant)

      get "/reservations/#{reservation.id}", as: :json
      expect(response.body).to eq reservation.to_json
    end
  end
end

require 'rails_helper'

describe RestaurantReservationManager::API do
# describe do
  context 'GET /reservations/' do
    it 'returns all reservations' do
      res = FactoryBot.create(:restaurant)
      table = FactoryBot.create(:table, restaurant: res)

      reservation = FactoryBot.create(:reservation, table: table, restaurant: res)

      get "/reservations", as: :json
      expect(response.body).to eq [reservation].to_json
    end
  end

  context 'GET /reservations/:id' do
    it 'returns a reservation' do
      res = FactoryBot.create(:restaurant)
      table = FactoryBot.create(:table, restaurant: res)

      reservation = FactoryBot.create(:reservation, table: table, restaurant: res)

      get "/reservations/#{reservation.id}", as: :json
      expect(response.body).to eq reservation.to_json
    end
  end
end

require 'rails_helper'

describe Resources::Restaurant::API do
# describe do
  context 'GET /restaurants/' do
    it 'returns all restaurants' do
      restaurant = FactoryBot.create(:restaurant)

      get "/restaurants", as: :json
      expect(response.body).to eq [restaurant].to_json
    end
  end

  context 'GET /restaurants/:id' do
    it 'returns a restaurant' do
      restaurant = FactoryBot.create(:restaurant)

      get "/restaurants/#{restaurant.id}", as: :json
      expect(response.body).to eq restaurant.to_json
    end
  end
end

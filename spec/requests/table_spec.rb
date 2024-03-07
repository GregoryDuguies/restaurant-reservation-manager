require 'rails_helper'

describe Resources::Table::API do
# describe do
  context 'GET /tables/' do
    it 'returns all tables' do
      restaurant = FactoryBot.create(:restaurant)
      table = FactoryBot.create(:table, restaurant: restaurant)

      get "/tables", as: :json
      expect(response.body).to eq [table].to_json
    end
  end

  context 'GET /tables/:id' do
    it 'returns a table' do
      restaurant = FactoryBot.create(:restaurant)
      table = FactoryBot.create(:table, restaurant: restaurant)

      get "/tables/#{table.id}", as: :json
      expect(response.body).to eq table.to_json
    end
  end
end

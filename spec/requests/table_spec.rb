require 'rails_helper'

describe Resources::Table::API do
  describe "#GET methods"do
    let!(:restaurant) { FactoryBot.create(:restaurant) }
    let!(:table) { FactoryBot.create(:table, restaurant: restaurant) }

    context 'GET /tables/' do
      it 'returns all tables' do
        get "/tables", as: :json
        expect(response.body).to eq [::API::Entities::Table.new(table)].to_json
      end
    end

    context 'GET /tables/:id' do
      it 'returns a table' do
        get "/tables/#{table.id}", as: :json
        expect(response.body).to eq ::API::Entities::Table.new(table).to_json
      end
    end

    context 'GET /tables/occupied/' do
      let!(:table_2) { FactoryBot.create(:table, restaurant: restaurant, capacity: 4) }

      let!(:reservation) do
        FactoryBot.create(:reservation,
                          restaurant: restaurant,
                          owner_name: 'Previous Tester',
                          owner_phone_number: '1-777-555-4444',
                          start_datetime: Time.zone.now + 12.hour,
                          total_guests: 4)
      end

      let!(:reservation_table) { FactoryBot.create(:reservation_table, reservation: reservation, table: table_2) }

      let(:params) do
        {
          restaurant_id: reservation.restaurant_id,
          reservation_datetime: reservation.start_datetime
        }
      end


      it 'returns all occupied tables given a datetime' do
        # 405 Not Allowed
        # get "/tables/occupied/", params: params, as: :json

        get "/tables/occupied?restaurant_id=#{params[:restaurant_id]}&reservation_datetime=#{params[:reservation_datetime]}", as: :json

        expect(response.body).to eq [::API::Entities::Table.new(table_2)].to_json
      end
    end
  end
end

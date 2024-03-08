require 'rails_helper'

describe Resources::Reservation::API do
  describe "#GET" do
    let!(:restaurant) { FactoryBot.create(:restaurant) }
    let!(:table) { FactoryBot.create(:table, restaurant: restaurant) }

    let!(:reservation) { FactoryBot.create(:reservation, restaurant: restaurant) }

    context 'GET /reservations/' do
      it 'returns all reservations' do
        get "/reservations", as: :json
        expect(response.body).to eq [::API::Entities::Reservation.new(reservation)].to_json
      end
    end

    context 'GET /reservations/:id' do
      it 'returns a reservation' do
        get "/reservations/#{reservation.id}", as: :json
        expect(response.body).to eq ::API::Entities::Reservation.new(reservation).to_json
      end
    end
  end

  context 'POST /reservations/' do
    let(:restaurant) { FactoryBot.create(:restaurant) }

    let!(:table_1) { FactoryBot.create(:table, restaurant: restaurant, capacity: 2) }
    let!(:table_2) { FactoryBot.create(:table, restaurant: restaurant, capacity: 2) }

    let(:params) do
      {restaurant_id: restaurant.id,
       owner_name: "Testing Test",
       owner_phone_number: "1-000-888-9999",
       start_datetime: Time.zone.now + 12.hour,
       total_guests: 3
      }
    end

    context 'when restaurant is not at capacity' do
      it 'creates and returns a reservation' do
        expect { post "/reservations/", params: params, as: :json }.to change{ Reservation.count }.by(1)

        reservation = Reservation.first

        expect(response.body).to eq ::API::Entities::Reservation.new(reservation).to_json
      end
    end

    context 'when restaurant is at capacity' do
      let!(:existing_reservation) do
        FactoryBot.create(:reservation,
                          restaurant: restaurant,
                          owner_name: 'Previous Tester',
                          owner_phone_number: '1-777-555-4444',
                          start_datetime: Time.zone.now + 12.hour,
                          total_guests: 4)
      end

      it 'does not create a reservation and returns an unprocessible entity' do
        expect { post "/reservations/", params: params, as: :json }.not_to change{ Reservation.count }

        expect(response.status).to eq 422
        expect(response.body).to eq "{\"error\":\"422 - Restaurant at Capacity\"}"
      end
    end
  end
end

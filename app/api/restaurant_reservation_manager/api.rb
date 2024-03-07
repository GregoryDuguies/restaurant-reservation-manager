require Rails.root.join('app', 'api', 'resources', 'reservation')
require Rails.root.join('app', 'api', 'resources', 'restaurant')
require Rails.root.join('app', 'api', 'resources', 'table')

module RestaurantReservationManager
  class API < Grape::API
    mount Resources::Reservation::API
    mount Resources::Restaurant::API
    mount Resources::Table::API
  end
end

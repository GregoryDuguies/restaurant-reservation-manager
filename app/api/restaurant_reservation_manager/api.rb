require Rails.root.join('app', 'api', 'resources', 'reservation')

module RestaurantReservationManager
  class API < Grape::API
    mount Resources::Reservation::API
  end
end

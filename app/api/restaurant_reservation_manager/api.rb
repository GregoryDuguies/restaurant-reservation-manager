require Rails.root.join('app', 'api', 'resources', 'reservation')
require Rails.root.join('app', 'api', 'resources', 'restaurant')
require Rails.root.join('app', 'api', 'resources', 'table')

require 'grape-swagger'

module RestaurantReservationManager
  class API < Grape::API
    mount Resources::Reservation::API
    mount Resources::Restaurant::API
    mount Resources::Table::API

    add_swagger_documentation \
      models: [
        ::API::Entities::Reservation,
        ::API::Entities::Restaurant,
        ::API::Entities::Table
      ]
  end
end

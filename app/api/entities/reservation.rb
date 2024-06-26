module API
  module Entities
    class Reservation < Grape::Entity
      expose :owner_name
      expose :owner_phone_number

      expose :start_datetime
      expose :end_datetime

      expose :total_guests
    end
  end
end

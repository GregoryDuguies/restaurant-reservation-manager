module API
  module Entities
    class Reservation < Grape::Entity
      expose :owner_name
      expose :owner_name

      expose :start_datetime
    end
  end
end

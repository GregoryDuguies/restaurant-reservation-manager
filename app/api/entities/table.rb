module API
  module Entities
    class Reservation < Grape::Entity
      expose :restaurant
      expose :number
      expose :capacity
    end
  end
end

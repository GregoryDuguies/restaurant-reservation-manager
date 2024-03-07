module API
  module Entities
    class Reservation < Grape::Entity
      expose :name
    end
  end
end

module API
  module Entities
    class Table < Grape::Entity
      expose :restaurant
      expose :number
      expose :capacity
    end
  end
end

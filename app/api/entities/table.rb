module API
  module Entities
    class Table < Grape::Entity
      expose :restaurant
      expose :number
    end
  end
end

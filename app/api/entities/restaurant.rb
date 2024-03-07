module API
  module Entities
    class Restaurant < Grape::Entity
      expose :name
      expose :capacity
    end
  end
end

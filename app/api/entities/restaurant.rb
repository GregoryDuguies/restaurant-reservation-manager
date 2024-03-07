module API
  module Entities
    class Restaurant < Grape::Entity
      expose :name
    end
  end
end

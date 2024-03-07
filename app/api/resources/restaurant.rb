module Resources
  module Restaurant
    class API < Grape::API
      # version 'v1', using: :header, vendor: 'twitter'

      format :json
      default_format :json

      # prefix :api

      # helpers do
      #   def current_user
      #     @current_user ||= User.authorize!(env)
      #   end

      #   def authenticate!
      #     error!('401 Unauthorized', 401) unless current_user
      #   end
      # end

      rescue_from :all do
        error!({ "error" => "Internal Server Error" }, 500)
      end

      resource :restaurants do

      	# TODO: Support pagination
        desc 'Return all restaurants'
        get do
          restaurants = ::Restaurant.all

          present restaurants
        end

        desc 'Return a restaurant'
        params do
          requires :id, type: Integer, desc: 'Restaurant ID.'
        end
        route_param :id do
          get do
            restaurant = ::Restaurant.find(params[:id])

            present restaurant
          end
        end
      end
    end
  end
end

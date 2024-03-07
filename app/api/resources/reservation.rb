module Resources
  module Reservation
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

      resource :reservations do
        desc 'Create a reservation.'
        params do
          requires :owner_name, type: String, allow_blank: false, desc: 'Owner\'s name.'
          requires :owner_phone_number, type: String, allow_blank: false, desc: 'Owner\'s phone number.'

          requires :start_datetime, type: DateTime, allow_blank: false, desc: 'Reservation Start Datetime'
        end

        post do
          # authenticate!
          reservation = Reservation.create!({
            user: current_user,
            owner_name: params[:owner_name]
          })

          present reservation
        end

        desc 'Return all reservations'
        get do
          reservations = ::Reservation.all

          present reservations
        end

        desc 'Return a reservation'
        params do
          requires :id, type: Integer, desc: 'Status ID.'
        end
        route_param :id do
          get do
            reservation = ::Reservation.find(params[:id])

            present reservation
          end
        end
      end
    end
  end
end

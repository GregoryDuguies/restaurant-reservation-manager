require Rails.root.join('app', 'api', 'entities', 'reservation')

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
          requires :restaurant_id, type: Integer, allow_blank: false, desc: 'Restaurant ID'
          requires :start_datetime, type: DateTime, allow_blank: false, desc: 'Reservation Start Datetime'

          requires :total_guests, type: Integer, allow_blank: false, desc: 'Reservation Total # of Guests'

          requires :owner_name, type: String, allow_blank: false, desc: 'Owner\'s name.'
          requires :owner_phone_number, type: String, allow_blank: false, desc: 'Owner\'s phone number.'
        end

        post do
          # authenticate!

          Reservation.transaction do
            restaurant = ::Restaurant.find(params[:restaurant_id])

            if restaurant.max_availability_within_span(params[:start_datetime], params[:start_datetime] + 2.hours) > params[:total_guests]
              reservation = ::Reservation.new(restaurant: restaurant,
                                            start_datetime: params[:start_datetime],
                                            end_datetime: params[:start_datetime] + 2.hours,
                                            total_guests: params[:total_guests],
                                            owner_name: params[:owner_name],
                                            owner_phone_number: params[:owner_phone_number])

              reservation.save!

              reservation.allocate_tables_v1

              present reservation, with: ::API::Entities::Reservation
            end
          else
            # Return invalid record if transaction fails - ideally this returned error messages for invalid data
            error!({ "error" => "422 - Restaurant at Capacity" }, 422)
          end
        end

        # TODO: Support pagination
        desc 'Return all reservations'
        get do
          reservations = ::Reservation.all

          present reservations, with: ::API::Entities::Reservation
        end

        desc 'Return a reservation'
        params do
          requires :id, type: Integer, desc: 'Reservation ID.'
        end
        route_param :id do
          get do
            reservation = ::Reservation.find(params[:id])

            present reservation, with: ::API::Entities::Reservation
          end
        end
      end
    end
  end
end

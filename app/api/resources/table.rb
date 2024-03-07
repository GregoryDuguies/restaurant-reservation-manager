require Rails.root.join('app', 'api', 'entities', 'table')

module Resources
  module Table
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

      resource :tables do

      	# TODO: Support pagination
        desc 'Return all tables'
        get do
          tables = ::Table.all

          present tables, with: ::API::Entities::Table
        end

        desc 'Return a table'
        params do
          requires :id, type: Integer, desc: 'Table ID.'
        end
        route_param :id do
          get do
            table = ::Table.find(params[:id])

            present table, with: ::API::Entities::Table
          end
        end
      end
    end
  end
end

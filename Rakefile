# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative "config/application"
require 'grape-swagger/rake/oapi_tasks'

GrapeSwagger::Rake::OapiTasks.new('::RestaurantReservationManager::API')
# Generate swagger doc
#> bundle exec rake oapi:fetch store=restaurant_reservation_manager.json

Rails.application.load_tasks

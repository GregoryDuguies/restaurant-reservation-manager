source "https://rubygems.org"

ruby "3.3.0"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.1.3", ">= 7.1.3.2"

gem "pg"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"

# Grape APIs for openapi schema
gem "grape"
gem 'grape-entity'
gem 'grape_on_rails_routes'
gem 'grape-swagger'

# For Grape::Entity ( https://github.com/ruby-grape/grape-entity )
gem 'grape-swagger-entity', '~> 0.3'
# For representable ( https://github.com/apotonick/representable )
gem 'grape-swagger-representable', '~> 0.2'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
# gem "jbuilder"

# Use Redis adapter to run Action Cable in production
# gem "redis", ">= 4.0.1"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin Ajax possible
# gem "rack-cors"

group :development, :test do
  gem "debug", ">= 1.0.0"
  gem 'rspec-rails', '~> 6.1.0'
  gem 'factory_bot_rails'
end

group :development do
end

group :test do
  gem 'shoulda-matchers', '~> 6.0'
end


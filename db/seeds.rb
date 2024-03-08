# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Seed Restaurants
["Oscar's Pizza", "Amy's Home Cookin", "Johnny's", "Congee Queen"].each do |name|
    Restaurant.find_or_create_by!(name: name)
  end


# Seed Tables for every Restaurant
Restaurant.unscoped.each do |restaurant|
  # Randomly add tables?!?
  total_tables = (1..10).to_a.sample

  (1..total_tables).each do |table_number|
    capacity = (1..10).to_a.sample

    table = restaurant.tables.find_or_create_by!(number: "Table #{table_number}", capacity: capacity)
  end
end


# Seed past and future Reservations

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

initial_datetime = Time.zone.now - 2.weeks

# Seed past and future Reservations
Restaurant.unscoped.each do |restaurant|
  restaurant.tables.each do |table|
    (0..7).each do |day|
      start_datetime = initial_datetime + day.days

      reservation = Reservation.new(
        restaurant: restaurant,
        owner_name: 'Previous Tester',
        owner_phone_number: '1-777-555-4444',
        start_datetime: start_datetime,
        end_datetime: start_datetime + 2.hours,
        total_guests: table.capacity
      )

      reservation.reservation_tables.build(table: table)

      reservation.save!
      reservation.reservation_tables.each(&:save!)
    end
  end
end

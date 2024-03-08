FactoryBot.define do
  factory :reservation do
    association :restaurant, factory: :restaurant

    owner_name { "Resy Best" }
    owner_phone_number { "1-888-999-0000" }

    start_datetime { Time.zone.now - 1.week }
    end_datetime { start_datetime + 2.hours }

    sequence :total_guests, (1..10).cycle
  end
end

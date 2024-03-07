FactoryBot.define do
  factory :reservation do
    association :restaurant, factory: :restaurant
    association :table, factory: :table

    owner_name { "Resy Best" }
    owner_phone_number { "1-888-999-0000" }

    start_datetime { Time.zone.now - 1.week }
  end
end

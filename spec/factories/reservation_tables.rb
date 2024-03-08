FactoryBot.define do
  factory :reservation_table do
    association :reservation, factory: :reservation
    association :table, factory: :table
  end
end

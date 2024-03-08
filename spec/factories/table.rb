FactoryBot.define do
  factory :table do
    association :restaurant, factory: :restaurant

    sequence(:number) { |i| "Table #{i}" }
    sequence :capacity, (2..8).cycle
  end
end

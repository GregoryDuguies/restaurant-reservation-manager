FactoryBot.define do
  factory :restaurant do
    sequence(:name) { |i| "Annie's Best Food #{i}" }

    sequence :capacity, (20..50).cycle
  end
end

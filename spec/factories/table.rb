FactoryBot.define do
  factory :table do
    association :restaurant, factory: :restaurant

    sequence(:number) { |i| "Annie's Best Food #{i}" }
  end
end

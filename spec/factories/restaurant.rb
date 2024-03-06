FactoryBot.define do
  factory :restaurant do
    sequence(:name) { |i| "Annie's Best Food #{i}" }
  end
end

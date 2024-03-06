FactoryBot.define do
  factory :table do
    sequence(:number) { |i| "Annie's Best Food #{i}" }

    capacity { 3 }
  end
end

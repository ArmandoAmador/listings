FactoryGirl.define do
  factory :listing do
    street { Faker::Address.street_address }
    status { %w(pending active sold).sample }
    price { rand(100_000..400_000) }
    bedrooms Faker::Number.between(1, 4)
    bathrooms Faker::Number.between(1, 4)
    sqft { rand(1000..4000) }
    lat { Faker::Address.latitude }
    lng { Faker::Address.longitude }
  end
end

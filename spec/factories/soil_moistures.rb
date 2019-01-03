FactoryBot.define do
  factory :soil_moisture do
    name { Faker::Name.unique.name }
  end
end

FactoryBot.define do
  factory :soil_texture do
    name { Faker::Name.unique.name }
  end
end

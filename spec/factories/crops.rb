FactoryBot.define do
  factory :crop do
    name { Faker::Name.unique.name }
  end
end

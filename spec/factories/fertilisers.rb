FactoryBot.define do
  factory :fertiliser do
    metric_name { Faker::Name.unique.name }
    imperial_name { Faker::Name.unique.name }
    nitrogen { 0.23 }
    phosphorus { 0.23 }
    potassium { 0.23 }
    sulfur { 0.23 }
    magnesium { 0.23 }
    metric_weight { 2.333 }
    imperial_weight { 1.3333 }
  end
end

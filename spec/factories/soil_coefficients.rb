FactoryBot.define do
  factory :soil_coefficient do
    soil_moisture
    soil_texture
    value { 1.5 }
  end
end

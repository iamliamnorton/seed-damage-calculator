require 'machinist/active_record'
require 'faker'

Crop.blueprint do
  name    { "#{Faker::Lorem.words.first}-#{sn}" }
end

Fertiliser.blueprint do
  name            { "#{Faker::Lorem.words.first}-#{sn}" }
  N               { rand().round(2) }
  P               { rand().round(2) }
  K               { rand().round(2) }
  S               { rand().round(2) }
  Mg              { rand().round(2) }
  liquid_weight   { rand().round(6) }
end

SoilTexture.blueprint do
  name            { "#{Faker::Lorem.words.first}-#{sn}" }
end

SoilMoisture.blueprint do
  name            { "#{Faker::Lorem.words.first}-#{sn}" }
end

SoilCoefficient.blueprint do
  value           { rand().round(2) }
  soil_texture
  soil_moisture
end

RegressionCoefficient.blueprint do
  value           { Random.new.rand(-5..5) + rand() }
  crop
  fertiliser
end

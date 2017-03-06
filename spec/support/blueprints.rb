require 'machinist/active_record'
require 'faker'

Crop.blueprint do
  name    { "Crop-#{sn}" }
end

Fertiliser.blueprint do
  metric_name     { "met-fert-#{sn}" }
  imperial_name   { "imp-fert-#{sn}" }
  N               { 0.33 }
  P               { 0.33 }
  K               { 0.33 }
  S               { 0.33 }
  Mg              { 0.33 }
  metric_weight   { 0.334329 }
  imperial_weight { 10.50 }
end

SoilTexture.blueprint do
  name            { "fine" }
end

SoilMoisture.blueprint do
  name            { "moist" }
end

SoilCoefficient.blueprint do
  value           { 1.5 }
  soil_texture
  soil_moisture
end

RegressionCoefficient.blueprint do
  value           { -0.131 }
  crop
  fertiliser
end

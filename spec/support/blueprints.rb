require 'machinist/active_record'
require 'faker'

Crop.blueprint do
  name    { "#{Faker::Lorem.words.first}-#{sn}" }
end

Fertiliser.blueprint do
  name    { "#{Faker::Lorem.words.first}-#{sn}" }
  N       { rand().round(2) }
  P       { rand().round(2) }
  K       { rand().round(2) }
  S       { rand().round(2) }
  Mg      { rand().round(2) }
  kgL     { rand().round(6) }
end

SoilTexture.blueprint do
  name    { "#{Faker::Lorem.words.first}-#{sn}" }
end

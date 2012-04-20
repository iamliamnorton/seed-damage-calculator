require 'machinist/active_record'
require 'faker'

# Add your blueprints here.
#
# e.g.
#   Post.blueprint do
#     title { "Post #{sn}" }
#     body  { "Lorem ipsum..." }
#   end

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

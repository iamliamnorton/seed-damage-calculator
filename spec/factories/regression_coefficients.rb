require 'factory_bot'

FactoryBot.define do
  factory :regression_coefficient do
    crop { create(:crop) }
    fertiliser { create(:fertiliser) }
    value { -0.131 }
  end
end

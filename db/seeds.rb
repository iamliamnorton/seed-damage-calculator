# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Crop.delete_all
Crop.create(:name => "Corn")
Crop.create(:name => "Soybean")
Crop.create(:name => "Wheat")
Crop.create(:name => "Wheat-durum")
Crop.create(:name => "Lucerne")
Crop.create(:name => "Barley")
Crop.create(:name => "Canola")
Crop.create(:name => "Cotton")
Crop.create(:name => "Linseed")
Crop.create(:name => "Lentil")
Crop.create(:name => "Mustard")
Crop.create(:name => "Oat")
Crop.create(:name => "Pea")
Crop.create(:name => "Safflower")
Crop.create(:name => "Sorghum")
Crop.create(:name => "Sunflower")

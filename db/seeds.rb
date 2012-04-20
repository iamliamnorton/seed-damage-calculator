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
Crop.create(:name => "Alfalfa/Lucerne")
Crop.create(:name => "Barley")
Crop.create(:name => "Canola")
Crop.create(:name => "Cotton")
Crop.create(:name => "Flax/Linseed")
Crop.create(:name => "Lentil")
Crop.create(:name => "Mustard")
Crop.create(:name => "Oat")
Crop.create(:name => "Pea")
Crop.create(:name => "Safflower")
Crop.create(:name => "Sorghum")
Crop.create(:name => "Sunflower")

Fertiliser.delete_all
Fertiliser.create(:name => "Urea(46-0-0)", :N => 0.46)
Fertiliser.create(:name => "Urea+NBPT", :N => 0.46)
Fertiliser.create(:name => "28-0-0", :N => 0.28, :kgL => 1.276151)
Fertiliser.create(:name => "Am.Nit (34-0-0)", :N => 0.34)
Fertiliser.create(:name => "DAP (18-46-0)", :N => 0.18, :P => 0.46)
Fertiliser.create(:name => "MAP (11-55-0)", :N => 0.11, :P => 0.55)
Fertiliser.create(:name => "TSP (0-46-0)", :P => 0.46)
Fertiliser.create(:name => "10-34-0", :N => 0.1, :P => 0.34, :kgL => 1.389987)
Fertiliser.create(:name => "7-21-7", :N => 0.07, :P => 0.21, :K => 0.07, :kgL => 1.282143)
Fertiliser.create(:name => "9-18-9", :N => 0.09, :P => 0.18, :K => 0.09, :kgL => 1.318091)
Fertiliser.create(:name => "3-18-18", :N => 0.03, :P => 0.18, :K => 0.18, :kgL => 1.401969)
Fertiliser.create(:name => "4-10-10", :N => 0.04, :P => 0.1, :K => 0.1, :kgL => 1.282143)
Fertiliser.create(:name => "KCL (0-0-60)", :K => 0.6)
Fertiliser.create(:name => "KSMg (0-0-22-22S-11Mg)", :K => 0.26, :S => 0.18, :Mg => 0.11)
Fertiliser.create(:name => "K Sulfate (0-0-50-17S)", :K => 0.51, :S => 0.19)
Fertiliser.create(:name => "ATS", :N => 0.12, :S => 0.26, :kgL => 1.330073)

SoilTexture.delete_all
SoilTexture.create(:name => "Fine")
SoilTexture.create(:name => "Medium")
SoilTexture.create(:name => "Coarse")

SoilMoisture.delete_all
SoilMoisture.create(:name => "Moist")
SoilMoisture.create(:name => "Borderline")
SoilMoisture.create(:name => "Dry")


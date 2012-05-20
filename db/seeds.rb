# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Crop.delete_all
corn = Crop.create(:name => "Corn")
soybean = Crop.create(:name => "Soybean")
wheat = Crop.create(:name => "Wheat")
durum = Crop.create(:name => "Wheat-durum")
alfalfa = Crop.create(:name => "Alfalfa/Lucerne")
barley = Crop.create(:name => "Barley")
canola = Crop.create(:name => "Canola")
cotton = Crop.create(:name => "Cotton")
flax = Crop.create(:name => "Flax/Linseed")
lentil = Crop.create(:name => "Lentil")
mustard = Crop.create(:name => "Mustard")
oat = Crop.create(:name => "Oat")
pea = Crop.create(:name => "Pea")
safflower = Crop.create(:name => "Safflower")
sorghum = Crop.create(:name => "Sorghum")
sunflower = Crop.create(:name => "Sunflower")

Fertiliser.delete_all
urea = Fertiliser.create(:metric_name => "Urea (46-0-0)", :imperial_name => "Urea (46-0-0)", :N => 0.46)
twentyeight = Fertiliser.create(:metric_name => "UAN (28-0-0)", :imperial_name => "UAN (28-0-0)", :N => 0.28, :liquid_weight => 1.276151)
amnit = Fertiliser.create(:metric_name => "Am.Nit (34-0-0)", :imperial_name => "Am.Nit (34-0-0)", :N => 0.34)
dap = Fertiliser.create(:metric_name => "DAP (18-20-0)", :imperial_name => "DAP (18-46-0)", :N => 0.18, :P => 0.46)
map = Fertiliser.create(:metric_name => "MAP (11-22-0)", :imperial_name => "MAP (11-55-0)", :N => 0.11, :P => 0.55)
tsp = Fertiliser.create(:metric_name => "TSP (0-20-0)", :imperial_name => "TSP (0-46-0)", :P => 0.46)
ten = Fertiliser.create(:metric_name => "APP (10-15-0)", :imperial_name => "APP (10-34-0)", :N => 0.1, :P => 0.34, :liquid_weight => 1.389987)
seven = Fertiliser.create(:metric_name => "7-9-6", :imperial_name => "7-21-7", :N => 0.07, :P => 0.21, :K => 0.07, :liquid_weight => 1.282143)
nine = Fertiliser.create(:metric_name => "9-8-7.5", :imperial_name => "9-18-9", :N => 0.09, :P => 0.18, :K => 0.09, :liquid_weight => 1.318091)
three = Fertiliser.create(:metric_name => "3-8-15", :imperial_name => "3-18-18", :N => 0.03, :P => 0.18, :K => 0.18, :liquid_weight => 1.401969)
four = Fertiliser.create(:metric_name => "4-4.4-8", :imperial_name => "4-10-10", :N => 0.04, :P => 0.1, :K => 0.1, :liquid_weight => 1.282143)
kcl = Fertiliser.create(:metric_name => "KCL (0-0-50)", :imperial_name => "KCL (0-0-60)", :K => 0.6)
ksmg = Fertiliser.create(:metric_name => "KsMg (0-0-18-22S-11Mg)", :imperial_name => "KsMg (0-0-22-22S-11Mg)", :K => 0.26, :S => 0.18, :Mg => 0.11)
ksulfate = Fertiliser.create(:metric_name => "KSul (0-0-42-17S)", :imperial_name => "KSul (0-0-50-17S)", :K => 0.51, :S => 0.19)
ats = Fertiliser.create(:metric_name => "ATS (12-0-0-26S)", :imperial_name => "ATS (12-0-0-26S)", :N => 0.12, :S => 0.26, :liquid_weight => 1.330073)

SoilTexture.delete_all
fine = SoilTexture.create(:name => "Fine")
medium = SoilTexture.create(:name => "Medium")
coarse = SoilTexture.create(:name => "Coarse")

SoilMoisture.delete_all
moist = SoilMoisture.create(:name => "Moist")
borderline = SoilMoisture.create(:name => "Borderline")
dry = SoilMoisture.create(:name => "Dry")

SoilCoefficient.delete_all
SoilCoefficient.create(:value => 0.75, :soil_texture_id => fine.id, :soil_moisture_id => moist.id)
SoilCoefficient.create(:value => 1, :soil_texture_id => fine.id, :soil_moisture_id => borderline.id)
SoilCoefficient.create(:value => 1.5, :soil_texture_id => fine.id, :soil_moisture_id => dry.id)
SoilCoefficient.create(:value => 1, :soil_texture_id => medium.id, :soil_moisture_id => moist.id)
SoilCoefficient.create(:value => 1.5, :soil_texture_id => medium.id, :soil_moisture_id => borderline.id)
SoilCoefficient.create(:value => 2, :soil_texture_id => medium.id, :soil_moisture_id => dry.id)
SoilCoefficient.create(:value => 1.5, :soil_texture_id => coarse.id, :soil_moisture_id => moist.id)
SoilCoefficient.create(:value => 2, :soil_texture_id => coarse.id, :soil_moisture_id => borderline.id)
SoilCoefficient.create(:value => 2.5, :soil_texture_id => coarse.id, :soil_moisture_id => dry.id)

RegressionCoefficient.delete_all

RegressionCoefficient.create(:value => -0.965, :crop_id => corn.id, :fertiliser_id => urea.id)
RegressionCoefficient.create(:value => -0.236, :crop_id => corn.id, :fertiliser_id => twentyeight.id)
RegressionCoefficient.create(:value => -0.215, :crop_id => corn.id, :fertiliser_id => amnit.id)
RegressionCoefficient.create(:value => -0.236, :crop_id => corn.id, :fertiliser_id => dap.id)
RegressionCoefficient.create(:value => -0.161, :crop_id => corn.id, :fertiliser_id => map.id)
RegressionCoefficient.create(:value => -0.099, :crop_id => corn.id, :fertiliser_id => tsp.id)
RegressionCoefficient.create(:value => -0.037, :crop_id => corn.id, :fertiliser_id => ten.id)
RegressionCoefficient.create(:value => -0.053, :crop_id => corn.id, :fertiliser_id => seven.id)
RegressionCoefficient.create(:value => -0.154, :crop_id => corn.id, :fertiliser_id => nine.id)
RegressionCoefficient.create(:value => -0.103, :crop_id => corn.id, :fertiliser_id => three.id)
RegressionCoefficient.create(:value => -0.045, :crop_id => corn.id, :fertiliser_id => four.id)
RegressionCoefficient.create(:value => -0.473, :crop_id => corn.id, :fertiliser_id => kcl.id)
RegressionCoefficient.create(:value => -0.215, :crop_id => corn.id, :fertiliser_id => ksmg.id)
RegressionCoefficient.create(:value => -0.095, :crop_id => corn.id, :fertiliser_id => ksulfate.id)
RegressionCoefficient.create(:value => -0.300, :crop_id => corn.id, :fertiliser_id => ats.id)

RegressionCoefficient.create(:value => -3.330, :crop_id => soybean.id, :fertiliser_id => urea.id)
RegressionCoefficient.create(:value => -1.703, :crop_id => soybean.id, :fertiliser_id => twentyeight.id)
RegressionCoefficient.create(:value => -2.378, :crop_id => soybean.id, :fertiliser_id => amnit.id)
RegressionCoefficient.create(:value => -1.080, :crop_id => soybean.id, :fertiliser_id => dap.id)
RegressionCoefficient.create(:value => -1.097, :crop_id => soybean.id, :fertiliser_id => map.id)
RegressionCoefficient.create(:value => -0.592, :crop_id => soybean.id, :fertiliser_id => tsp.id)
RegressionCoefficient.create(:value => -0.478, :crop_id => soybean.id, :fertiliser_id => ten.id)
RegressionCoefficient.create(:value => -0.597, :crop_id => soybean.id, :fertiliser_id => seven.id)
RegressionCoefficient.create(:value => -0.688, :crop_id => soybean.id, :fertiliser_id => nine.id)
RegressionCoefficient.create(:value => -0.521, :crop_id => soybean.id, :fertiliser_id => three.id)
RegressionCoefficient.create(:value => -0.506, :crop_id => soybean.id, :fertiliser_id => four.id)
RegressionCoefficient.create(:value => -2.166, :crop_id => soybean.id, :fertiliser_id => kcl.id)
RegressionCoefficient.create(:value => -0.822, :crop_id => soybean.id, :fertiliser_id => ksmg.id)
RegressionCoefficient.create(:value => -0.693, :crop_id => soybean.id, :fertiliser_id => ksulfate.id)
RegressionCoefficient.create(:value => -4.001, :crop_id => soybean.id, :fertiliser_id => ats.id)

RegressionCoefficient.create(:value => -1.436, :crop_id => wheat.id, :fertiliser_id => urea.id)
RegressionCoefficient.create(:value => -0.258, :crop_id => wheat.id, :fertiliser_id => twentyeight.id)
RegressionCoefficient.create(:value => -0.893, :crop_id => wheat.id, :fertiliser_id => amnit.id)
RegressionCoefficient.create(:value => -0.541, :crop_id => wheat.id, :fertiliser_id => dap.id)
RegressionCoefficient.create(:value => -0.406, :crop_id => wheat.id, :fertiliser_id => map.id)
RegressionCoefficient.create(:value => -0.266, :crop_id => wheat.id, :fertiliser_id => tsp.id)
RegressionCoefficient.create(:value => -0.105, :crop_id => wheat.id, :fertiliser_id => ten.id)
RegressionCoefficient.create(:value => -0.143, :crop_id => wheat.id, :fertiliser_id => seven.id)
RegressionCoefficient.create(:value => -0.140, :crop_id => wheat.id, :fertiliser_id => nine.id)
RegressionCoefficient.create(:value => -0.070, :crop_id => wheat.id, :fertiliser_id => three.id)
RegressionCoefficient.create(:value => -0.050, :crop_id => wheat.id, :fertiliser_id => four.id)
RegressionCoefficient.create(:value => -0.891, :crop_id => wheat.id, :fertiliser_id => kcl.id)
RegressionCoefficient.create(:value => -0.558, :crop_id => wheat.id, :fertiliser_id => ksmg.id)
RegressionCoefficient.create(:value => -0.474, :crop_id => wheat.id, :fertiliser_id => ksulfate.id)
RegressionCoefficient.create(:value => -1.169, :crop_id => wheat.id, :fertiliser_id => ats.id)

RegressionCoefficient.create(:value => -1.468, :crop_id => durum.id, :fertiliser_id => urea.id)
RegressionCoefficient.create(:value => -0.396, :crop_id => durum.id, :fertiliser_id => twentyeight.id)
RegressionCoefficient.create(:value => -1.107, :crop_id => durum.id, :fertiliser_id => amnit.id)
RegressionCoefficient.create(:value => -0.617, :crop_id => durum.id, :fertiliser_id => dap.id)
RegressionCoefficient.create(:value => -0.700, :crop_id => durum.id, :fertiliser_id => map.id)
RegressionCoefficient.create(:value => -0.328, :crop_id => durum.id, :fertiliser_id => tsp.id)
RegressionCoefficient.create(:value => -0.234, :crop_id => durum.id, :fertiliser_id => ten.id)
RegressionCoefficient.create(:value => -0.153, :crop_id => durum.id, :fertiliser_id => seven.id)
RegressionCoefficient.create(:value => -0.193, :crop_id => durum.id, :fertiliser_id => nine.id)
RegressionCoefficient.create(:value => -0.165, :crop_id => durum.id, :fertiliser_id => three.id)
RegressionCoefficient.create(:value => -0.200, :crop_id => durum.id, :fertiliser_id => four.id)
RegressionCoefficient.create(:value => -1.156, :crop_id => durum.id, :fertiliser_id => kcl.id)
RegressionCoefficient.create(:value => -0.578, :crop_id => durum.id, :fertiliser_id => ksmg.id)
RegressionCoefficient.create(:value => -0.569, :crop_id => durum.id, :fertiliser_id => ksulfate.id)
RegressionCoefficient.create(:value => -0.934, :crop_id => durum.id, :fertiliser_id => ats.id)

RegressionCoefficient.create(:value => -6.373, :crop_id => alfalfa.id, :fertiliser_id => urea.id)
RegressionCoefficient.create(:value => -2.821, :crop_id => alfalfa.id, :fertiliser_id => twentyeight.id)
RegressionCoefficient.create(:value => -2.924, :crop_id => alfalfa.id, :fertiliser_id => amnit.id)
RegressionCoefficient.create(:value => -1.074, :crop_id => alfalfa.id, :fertiliser_id => dap.id)
RegressionCoefficient.create(:value => -1.107, :crop_id => alfalfa.id, :fertiliser_id => map.id)
RegressionCoefficient.create(:value => -0.955, :crop_id => alfalfa.id, :fertiliser_id => tsp.id)
RegressionCoefficient.create(:value => -0.650, :crop_id => alfalfa.id, :fertiliser_id => ten.id)
RegressionCoefficient.create(:value => -0.381, :crop_id => alfalfa.id, :fertiliser_id => seven.id)
RegressionCoefficient.create(:value => -1.157, :crop_id => alfalfa.id, :fertiliser_id => nine.id)
RegressionCoefficient.create(:value => -0.573, :crop_id => alfalfa.id, :fertiliser_id => three.id)
RegressionCoefficient.create(:value => -0.303, :crop_id => alfalfa.id, :fertiliser_id => four.id)
RegressionCoefficient.create(:value => -1.505, :crop_id => alfalfa.id, :fertiliser_id => kcl.id)
RegressionCoefficient.create(:value => -0.725, :crop_id => alfalfa.id, :fertiliser_id => ksmg.id)
RegressionCoefficient.create(:value => -0.970, :crop_id => alfalfa.id, :fertiliser_id => ksulfate.id)
RegressionCoefficient.create(:value => -4.418, :crop_id => alfalfa.id, :fertiliser_id => ats.id)

RegressionCoefficient.create(:value => -1.207, :crop_id => barley.id, :fertiliser_id => urea.id)
RegressionCoefficient.create(:value => -0.281, :crop_id => barley.id, :fertiliser_id => twentyeight.id)
RegressionCoefficient.create(:value => -0.432, :crop_id => barley.id, :fertiliser_id => amnit.id)
RegressionCoefficient.create(:value => -0.477, :crop_id => barley.id, :fertiliser_id => dap.id)
RegressionCoefficient.create(:value => -0.302, :crop_id => barley.id, :fertiliser_id => map.id)
RegressionCoefficient.create(:value => -0.179, :crop_id => barley.id, :fertiliser_id => tsp.id)
RegressionCoefficient.create(:value => -0.199, :crop_id => barley.id, :fertiliser_id => ten.id)
RegressionCoefficient.create(:value => -0.058, :crop_id => barley.id, :fertiliser_id => seven.id)
RegressionCoefficient.create(:value => -0.125, :crop_id => barley.id, :fertiliser_id => nine.id)
RegressionCoefficient.create(:value => -0.098, :crop_id => barley.id, :fertiliser_id => three.id)
RegressionCoefficient.create(:value => -0.081, :crop_id => barley.id, :fertiliser_id => four.id)
RegressionCoefficient.create(:value => -0.618, :crop_id => barley.id, :fertiliser_id => kcl.id)
RegressionCoefficient.create(:value => -0.364, :crop_id => barley.id, :fertiliser_id => ksmg.id)
RegressionCoefficient.create(:value => -0.212, :crop_id => barley.id, :fertiliser_id => ksulfate.id)
RegressionCoefficient.create(:value => -1.306, :crop_id => barley.id, :fertiliser_id => ats.id)

RegressionCoefficient.create(:value => -4.457, :crop_id => canola.id, :fertiliser_id => urea.id)
RegressionCoefficient.create(:value => -1.873, :crop_id => canola.id, :fertiliser_id => twentyeight.id)
RegressionCoefficient.create(:value => -3.034, :crop_id => canola.id, :fertiliser_id => amnit.id)
RegressionCoefficient.create(:value => -1.567, :crop_id => canola.id, :fertiliser_id => dap.id)
RegressionCoefficient.create(:value => -0.971, :crop_id => canola.id, :fertiliser_id => map.id)
RegressionCoefficient.create(:value => -0.977, :crop_id => canola.id, :fertiliser_id => tsp.id)
RegressionCoefficient.create(:value => -0.685, :crop_id => canola.id, :fertiliser_id => ten.id)
RegressionCoefficient.create(:value => -0.483, :crop_id => canola.id, :fertiliser_id => seven.id)
RegressionCoefficient.create(:value => -0.673, :crop_id => canola.id, :fertiliser_id => nine.id)
RegressionCoefficient.create(:value => -0.613, :crop_id => canola.id, :fertiliser_id => three.id)
RegressionCoefficient.create(:value => -0.269, :crop_id => canola.id, :fertiliser_id => four.id)
RegressionCoefficient.create(:value => -1.479, :crop_id => canola.id, :fertiliser_id => kcl.id)
RegressionCoefficient.create(:value => -0.981, :crop_id => canola.id, :fertiliser_id => ksmg.id)
RegressionCoefficient.create(:value => -1.177, :crop_id => canola.id, :fertiliser_id => ksulfate.id)
RegressionCoefficient.create(:value => -2.920, :crop_id => canola.id, :fertiliser_id => ats.id)

RegressionCoefficient.create(:value => -3.201, :crop_id => cotton.id, :fertiliser_id => urea.id)
RegressionCoefficient.create(:value => -0.640, :crop_id => cotton.id, :fertiliser_id => twentyeight.id)
RegressionCoefficient.create(:value => -0.621, :crop_id => cotton.id, :fertiliser_id => amnit.id)
RegressionCoefficient.create(:value => -0.645, :crop_id => cotton.id, :fertiliser_id => dap.id)
RegressionCoefficient.create(:value => -0.607, :crop_id => cotton.id, :fertiliser_id => map.id)
RegressionCoefficient.create(:value => -0.207, :crop_id => cotton.id, :fertiliser_id => tsp.id)
RegressionCoefficient.create(:value => -0.455, :crop_id => cotton.id, :fertiliser_id => ten.id)
RegressionCoefficient.create(:value => -0.255, :crop_id => cotton.id, :fertiliser_id => seven.id)
RegressionCoefficient.create(:value => -0.468, :crop_id => cotton.id, :fertiliser_id => nine.id)
RegressionCoefficient.create(:value => -0.313, :crop_id => cotton.id, :fertiliser_id => three.id)
RegressionCoefficient.create(:value => -0.123, :crop_id => cotton.id, :fertiliser_id => four.id)
RegressionCoefficient.create(:value => -0.982, :crop_id => cotton.id, :fertiliser_id => kcl.id)
RegressionCoefficient.create(:value => -0.623, :crop_id => cotton.id, :fertiliser_id => ksmg.id)
RegressionCoefficient.create(:value => -0.564, :crop_id => cotton.id, :fertiliser_id => ksulfate.id)
RegressionCoefficient.create(:value => -2.090, :crop_id => cotton.id, :fertiliser_id => ats.id)

RegressionCoefficient.create(:value => -7.208, :crop_id => flax.id, :fertiliser_id => urea.id)
RegressionCoefficient.create(:value => -2.495, :crop_id => flax.id, :fertiliser_id => twentyeight.id)
RegressionCoefficient.create(:value => -2.479, :crop_id => flax.id, :fertiliser_id => amnit.id)
RegressionCoefficient.create(:value => -1.153, :crop_id => flax.id, :fertiliser_id => dap.id)
RegressionCoefficient.create(:value => -0.902, :crop_id => flax.id, :fertiliser_id => map.id)
RegressionCoefficient.create(:value => -0.655, :crop_id => flax.id, :fertiliser_id => tsp.id)
RegressionCoefficient.create(:value => -0.537, :crop_id => flax.id, :fertiliser_id => ten.id)
RegressionCoefficient.create(:value => -0.291, :crop_id => flax.id, :fertiliser_id => seven.id)
RegressionCoefficient.create(:value => -0.827, :crop_id => flax.id, :fertiliser_id => nine.id)
RegressionCoefficient.create(:value => -0.617, :crop_id => flax.id, :fertiliser_id => three.id)
RegressionCoefficient.create(:value => -0.162, :crop_id => flax.id, :fertiliser_id => four.id)
RegressionCoefficient.create(:value => -1.419, :crop_id => flax.id, :fertiliser_id => kcl.id)
RegressionCoefficient.create(:value => -0.749, :crop_id => flax.id, :fertiliser_id => ksmg.id)
RegressionCoefficient.create(:value => -0.954, :crop_id => flax.id, :fertiliser_id => ksulfate.id)
RegressionCoefficient.create(:value => -1.981, :crop_id => flax.id, :fertiliser_id => ats.id)

RegressionCoefficient.create(:value => -2.706, :crop_id => lentil.id, :fertiliser_id => urea.id)
RegressionCoefficient.create(:value => -1.290, :crop_id => lentil.id, :fertiliser_id => twentyeight.id)
RegressionCoefficient.create(:value => -1.825, :crop_id => lentil.id, :fertiliser_id => amnit.id)
RegressionCoefficient.create(:value => -1.141, :crop_id => lentil.id, :fertiliser_id => dap.id)
RegressionCoefficient.create(:value => -1.115, :crop_id => lentil.id, :fertiliser_id => map.id)
RegressionCoefficient.create(:value => -0.587, :crop_id => lentil.id, :fertiliser_id => tsp.id)
RegressionCoefficient.create(:value => -0.582, :crop_id => lentil.id, :fertiliser_id => ten.id)
RegressionCoefficient.create(:value => -0.474, :crop_id => lentil.id, :fertiliser_id => seven.id)
RegressionCoefficient.create(:value => -0.502, :crop_id => lentil.id, :fertiliser_id => nine.id)
RegressionCoefficient.create(:value => -0.424, :crop_id => lentil.id, :fertiliser_id => three.id)
RegressionCoefficient.create(:value => -0.314, :crop_id => lentil.id, :fertiliser_id => four.id)
RegressionCoefficient.create(:value => -1.632, :crop_id => lentil.id, :fertiliser_id => kcl.id)
RegressionCoefficient.create(:value => -0.799, :crop_id => lentil.id, :fertiliser_id => ksmg.id)
RegressionCoefficient.create(:value => -0.824, :crop_id => lentil.id, :fertiliser_id => ksulfate.id)
RegressionCoefficient.create(:value => -2.856, :crop_id => lentil.id, :fertiliser_id => ats.id)

RegressionCoefficient.create(:value => -2.903, :crop_id => mustard.id, :fertiliser_id => urea.id)
RegressionCoefficient.create(:value => -2.017, :crop_id => mustard.id, :fertiliser_id => twentyeight.id)
RegressionCoefficient.create(:value => -2.604, :crop_id => mustard.id, :fertiliser_id => amnit.id)
RegressionCoefficient.create(:value => -1.182, :crop_id => mustard.id, :fertiliser_id => dap.id)
RegressionCoefficient.create(:value => -1.235, :crop_id => mustard.id, :fertiliser_id => map.id)
RegressionCoefficient.create(:value => -1.061, :crop_id => mustard.id, :fertiliser_id => tsp.id)
RegressionCoefficient.create(:value => -0.340, :crop_id => mustard.id, :fertiliser_id => ten.id)
RegressionCoefficient.create(:value => -0.303, :crop_id => mustard.id, :fertiliser_id => seven.id)
RegressionCoefficient.create(:value => -0.694, :crop_id => mustard.id, :fertiliser_id => nine.id)
RegressionCoefficient.create(:value => -0.493, :crop_id => mustard.id, :fertiliser_id => three.id)
RegressionCoefficient.create(:value => -0.252, :crop_id => mustard.id, :fertiliser_id => four.id)
RegressionCoefficient.create(:value => -2.357, :crop_id => mustard.id, :fertiliser_id => kcl.id)
RegressionCoefficient.create(:value => -0.883, :crop_id => mustard.id, :fertiliser_id => ksmg.id)
RegressionCoefficient.create(:value => -1.398, :crop_id => mustard.id, :fertiliser_id => ksulfate.id)
RegressionCoefficient.create(:value => -4.540, :crop_id => mustard.id, :fertiliser_id => ats.id)

RegressionCoefficient.create(:value => -1.634, :crop_id => oat.id, :fertiliser_id => urea.id)
RegressionCoefficient.create(:value => -0.551, :crop_id => oat.id, :fertiliser_id => twentyeight.id)
RegressionCoefficient.create(:value => -0.807, :crop_id => oat.id, :fertiliser_id => amnit.id)
RegressionCoefficient.create(:value => -0.545, :crop_id => oat.id, :fertiliser_id => dap.id)
RegressionCoefficient.create(:value => -0.578, :crop_id => oat.id, :fertiliser_id => map.id)
RegressionCoefficient.create(:value => -0.210, :crop_id => oat.id, :fertiliser_id => tsp.id)
RegressionCoefficient.create(:value => -0.213, :crop_id => oat.id, :fertiliser_id => ten.id)
RegressionCoefficient.create(:value => -0.193, :crop_id => oat.id, :fertiliser_id => seven.id)
RegressionCoefficient.create(:value => -0.378, :crop_id => oat.id, :fertiliser_id => nine.id)
RegressionCoefficient.create(:value => -0.099, :crop_id => oat.id, :fertiliser_id => three.id)
RegressionCoefficient.create(:value => -0.121, :crop_id => oat.id, :fertiliser_id => four.id)
RegressionCoefficient.create(:value => -1.067, :crop_id => oat.id, :fertiliser_id => kcl.id)
RegressionCoefficient.create(:value => -0.782, :crop_id => oat.id, :fertiliser_id => ksmg.id)
RegressionCoefficient.create(:value => -0.507, :crop_id => oat.id, :fertiliser_id => ksulfate.id)
RegressionCoefficient.create(:value => -1.889, :crop_id => oat.id, :fertiliser_id => ats.id)

RegressionCoefficient.create(:value => -1.489, :crop_id => pea.id, :fertiliser_id => urea.id)
RegressionCoefficient.create(:value => -0.799, :crop_id => pea.id, :fertiliser_id => twentyeight.id)
RegressionCoefficient.create(:value => -1.062, :crop_id => pea.id, :fertiliser_id => amnit.id)
RegressionCoefficient.create(:value => -0.703, :crop_id => pea.id, :fertiliser_id => dap.id)
RegressionCoefficient.create(:value => -0.678, :crop_id => pea.id, :fertiliser_id => map.id)
RegressionCoefficient.create(:value => -0.247, :crop_id => pea.id, :fertiliser_id => tsp.id)
RegressionCoefficient.create(:value => -0.143, :crop_id => pea.id, :fertiliser_id => ten.id)
RegressionCoefficient.create(:value => -0.218, :crop_id => pea.id, :fertiliser_id => seven.id)
RegressionCoefficient.create(:value => -0.222, :crop_id => pea.id, :fertiliser_id => nine.id)
RegressionCoefficient.create(:value => -0.240, :crop_id => pea.id, :fertiliser_id => three.id)
RegressionCoefficient.create(:value => -0.121, :crop_id => pea.id, :fertiliser_id => four.id)
RegressionCoefficient.create(:value => -1.282, :crop_id => pea.id, :fertiliser_id => kcl.id)
RegressionCoefficient.create(:value => -0.344, :crop_id => pea.id, :fertiliser_id => ksmg.id)
RegressionCoefficient.create(:value => -0.449, :crop_id => pea.id, :fertiliser_id => ksulfate.id)
RegressionCoefficient.create(:value => -4.557, :crop_id => pea.id, :fertiliser_id => ats.id)

RegressionCoefficient.create(:value => -3.175, :crop_id => safflower.id, :fertiliser_id => urea.id)
RegressionCoefficient.create(:value => -1.539, :crop_id => safflower.id, :fertiliser_id => twentyeight.id)
RegressionCoefficient.create(:value => -2.271, :crop_id => safflower.id, :fertiliser_id => amnit.id)
RegressionCoefficient.create(:value => -1.082, :crop_id => safflower.id, :fertiliser_id => dap.id)
RegressionCoefficient.create(:value => -0.777, :crop_id => safflower.id, :fertiliser_id => map.id)
RegressionCoefficient.create(:value => -0.610, :crop_id => safflower.id, :fertiliser_id => tsp.id)
RegressionCoefficient.create(:value => -0.583, :crop_id => safflower.id, :fertiliser_id => ten.id)
RegressionCoefficient.create(:value => -0.387, :crop_id => safflower.id, :fertiliser_id => seven.id)
RegressionCoefficient.create(:value => -0.557, :crop_id => safflower.id, :fertiliser_id => nine.id)
RegressionCoefficient.create(:value => -0.452, :crop_id => safflower.id, :fertiliser_id => three.id)
RegressionCoefficient.create(:value => -0.286, :crop_id => safflower.id, :fertiliser_id => four.id)
RegressionCoefficient.create(:value => -1.426, :crop_id => safflower.id, :fertiliser_id => kcl.id)
RegressionCoefficient.create(:value => -0.663, :crop_id => safflower.id, :fertiliser_id => ksmg.id)
RegressionCoefficient.create(:value => -0.693, :crop_id => safflower.id, :fertiliser_id => ksulfate.id)
RegressionCoefficient.create(:value => -2.976, :crop_id => safflower.id, :fertiliser_id => ats.id)

RegressionCoefficient.create(:value => -2.521, :crop_id => sorghum.id, :fertiliser_id => urea.id)
RegressionCoefficient.create(:value => -0.825, :crop_id => sorghum.id, :fertiliser_id => twentyeight.id)
RegressionCoefficient.create(:value => -1.038, :crop_id => sorghum.id, :fertiliser_id => amnit.id)
RegressionCoefficient.create(:value => -0.862, :crop_id => sorghum.id, :fertiliser_id => dap.id)
RegressionCoefficient.create(:value => -0.465, :crop_id => sorghum.id, :fertiliser_id => map.id)
RegressionCoefficient.create(:value => -0.274, :crop_id => sorghum.id, :fertiliser_id => tsp.id)
RegressionCoefficient.create(:value => -0.172, :crop_id => sorghum.id, :fertiliser_id => ten.id)
RegressionCoefficient.create(:value => -0.166, :crop_id => sorghum.id, :fertiliser_id => seven.id)
RegressionCoefficient.create(:value => -0.501, :crop_id => sorghum.id, :fertiliser_id => nine.id)
RegressionCoefficient.create(:value => -0.263, :crop_id => sorghum.id, :fertiliser_id => three.id)
RegressionCoefficient.create(:value => -0.122, :crop_id => sorghum.id, :fertiliser_id => four.id)
RegressionCoefficient.create(:value => -1.189, :crop_id => sorghum.id, :fertiliser_id => kcl.id)
RegressionCoefficient.create(:value => -0.803, :crop_id => sorghum.id, :fertiliser_id => ksmg.id)
RegressionCoefficient.create(:value => -0.984, :crop_id => sorghum.id, :fertiliser_id => ksulfate.id)
RegressionCoefficient.create(:value => -1.774, :crop_id => sorghum.id, :fertiliser_id => ats.id)

RegressionCoefficient.create(:value => -2.258, :crop_id => sunflower.id, :fertiliser_id => urea.id)
RegressionCoefficient.create(:value => -0.556, :crop_id => sunflower.id, :fertiliser_id => twentyeight.id)
RegressionCoefficient.create(:value => -0.993, :crop_id => sunflower.id, :fertiliser_id => amnit.id)
RegressionCoefficient.create(:value => -0.306, :crop_id => sunflower.id, :fertiliser_id => dap.id)
RegressionCoefficient.create(:value => -0.367, :crop_id => sunflower.id, :fertiliser_id => map.id)
RegressionCoefficient.create(:value => -0.335, :crop_id => sunflower.id, :fertiliser_id => tsp.id)
RegressionCoefficient.create(:value => -0.244, :crop_id => sunflower.id, :fertiliser_id => ten.id)
RegressionCoefficient.create(:value => -0.163, :crop_id => sunflower.id, :fertiliser_id => seven.id)
RegressionCoefficient.create(:value => -0.328, :crop_id => sunflower.id, :fertiliser_id => nine.id)
RegressionCoefficient.create(:value => -0.155, :crop_id => sunflower.id, :fertiliser_id => three.id)
RegressionCoefficient.create(:value => -0.098, :crop_id => sunflower.id, :fertiliser_id => four.id)
RegressionCoefficient.create(:value => -0.764, :crop_id => sunflower.id, :fertiliser_id => kcl.id)
RegressionCoefficient.create(:value => -0.261, :crop_id => sunflower.id, :fertiliser_id => ksmg.id)
RegressionCoefficient.create(:value => -0.337, :crop_id => sunflower.id, :fertiliser_id => ksulfate.id)
RegressionCoefficient.create(:value => -1.758, :crop_id => sunflower.id, :fertiliser_id => ats.id)

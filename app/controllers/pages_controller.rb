class PagesController < ApplicationController
  before_action :satellite_page

  def theory
    @crops = Crop.order('name')
    @fertilisers = Fertiliser.all
    @soil_moistures = SoilMoisture.all
    @soil_textures = SoilTexture.all
  end

  def disclaimer
  end

  def definitions
  end

  def satellite_page
    @satellite_page ||= true
  end
end

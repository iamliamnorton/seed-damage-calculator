class PagesController < ApplicationController
  caches_page :theory, :disclaimer, :definitions

  before_filter :satellite_page

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

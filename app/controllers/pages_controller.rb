class PagesController < ApplicationController
  caches_page :theory, :disclaimer, :definitions

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
end

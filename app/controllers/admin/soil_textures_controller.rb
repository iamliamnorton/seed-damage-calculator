class Admin::SoilTexturesController < Admin::BaseController
  before_filter :load_soil_texture, :only => [:edit, :update, :destroy]

  def index
    @soil_textures = SoilTexture.all
  end
  def new
    @soil_texture = SoilTexture.new
  end

  def edit
  end

  def create
    @soil_texture = SoilTexture.new(params[:soil_texture])
    @soil_moistures = SoilMoisture.all

    if @soil_texture.save
      @soil_moistures.each do |soil_moisture|
        SoilCoefficient.create(:soil_texture_id => @soil_texture.id, :soil_moisture_id => soil_moisture.id)
      end
      clear_cache
      flash[:notice] = 'Soil texture was successfully created.'
      redirect_to admin_soil_textures_path
    else
      render :new
    end
  end

  def update
    if @soil_texture.update_attributes(params[:soil_texture])
      clear_cache
      flash[:notice] = 'Soil texture was successfully updated.'
      redirect_to admin_soil_textures_path
    else
      render :edit
    end
  end

  def destroy
    clear_cache
    @soil_texture.destroy
    flash[:notice] = 'Soil texture was successfully destroyed.'
    redirect_to admin_soil_textures_path
  end

  private

  def load_soil_texture
    @soil_texture = SoilTexture.find(params[:id])
  end
end

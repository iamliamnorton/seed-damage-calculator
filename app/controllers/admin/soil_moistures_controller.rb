class Admin::SoilMoisturesController < Admin::BaseController
  before_filter :load_soil_moisture, :only => [:edit, :update, :destroy]

  def index
    @soil_moistures = SoilMoisture.all
  end

  def new
    @soil_moisture = SoilMoisture.new
  end

  def edit
  end

  def create
    @soil_moisture = SoilMoisture.new(params[:soil_moisture])
    @soil_textures = SoilTexture.all

    if @soil_moisture.save
      @soil_textures.each do |soil_texture|
        SoilCoefficient.create(:soil_texture_id => soil_texture.id, :soil_moisture_id => @soil_moisture.id)
      end
      clear_cache
      flash[:notice] = 'Soil moisture was successfully created.'
      redirect_to admin_soil_moistures_path
    else
      render :new
    end
  end

  def update
    if @soil_moisture.update_attributes(params[:soil_moisture])
      clear_cache
      flash[:notice] = 'Soil moisture was successfully updated.'
      redirect_to admin_soil_moistures_path
    else
      render :edit
    end
  end

  def destroy
    clear_cache
    @soil_moisture.destroy
    flash[:notice] = 'Soil moisture was successfully destroyed.'
    redirect_to admin_soil_moistures_path
  end

  private

  def load_soil_moisture
    @soil_moisture = SoilMoisture.find(params[:id])
  end
end

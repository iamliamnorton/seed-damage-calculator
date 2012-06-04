class Admin::SoilTexturesController < Admin::BaseController

  before_filter :load_soil_texture, :only => [:edit, :update, :destroy]

  def load_soil_texture
     @soil_texture = SoilTexture.find(params[:id])
  end

  # GET /soil_textures
  def index
    @soil_textures = SoilTexture.all
  end

  # GET /soil_textures/new
  def new
    @soil_texture = SoilTexture.new
  end

  # GET /soil_textures/1/edit
  def edit
  end

  # POST /soil_textures
  def create
    @soil_texture = SoilTexture.new(params[:soil_texture])
    @soil_moistures = SoilMoisture.all

    if @soil_texture.save
      @soil_moistures.each do |soil_moisture|
        SoilCoefficient.create(:soil_texture_id => @soil_texture.id, :soil_moisture_id => soil_moisture.id)
      end
      flash[:notice] = 'Soil texture was successfully created.'
      redirect_to admin_soil_textures_path
    else
      render :new
    end
  end

  # PUT /soil_textures/1
  def update
    if @soil_texture.update_attributes(params[:soil_texture])
      flash[:notice] = 'Soil texture was successfully updated.'
      redirect_to admin_soil_textures_path
    else
      render :edit
    end
  end

  # DELETE /soil_textures/1
  def destroy
    @soil_texture.destroy
    flash[:notice] = 'Soil texture was successfully destroyed.'
    redirect_to admin_soil_textures_path
  end

end

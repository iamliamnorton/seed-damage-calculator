class Admin::SoilCoefficientsController < Admin::BaseController

  before_filter :load_soil_coefficient, :only => [:edit, :update, :destroy]
  before_filter :load_soil_attributes, :except => [:destroy]

  def load_soil_coefficient
     @soil_coefficient = SoilCoefficient.find(params[:id])
  end

  def load_soil_attributes
     @soil_moistures = SoilMoisture.all
     @soil_textures = SoilTexture.all
  end

  # GET /soil_coefficients
  def index
    @soil_coefficients = SoilCoefficient.all
  end

  # GET /soil_coefficients/1/edit
  def edit
  end

  # PUT /soil_coefficients/1
  # POST /soil_coefficients/1.json
  def update
    respond_to do |format|
      if @soil_coefficient.update_attributes(params[:soil_coefficient])
        format.html { redirect_to admin_soil_coefficients_path, notice: 'Soil coefficient was successfully updated.' }
        format.json { respond_with_bip(@soil_coefficient) }
      else
        format.html { render :edit }
        format.json { respond_with_bip(@soil_coefficient) }
      end
    end
  end
end

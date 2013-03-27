class Admin::SoilCoefficientsController < Admin::BaseController
  before_filter :load_soil_coefficient, :only => [:edit, :update, :destroy]
  before_filter :load_soil_attributes, :except => [:destroy]

  def index
    @soil_coefficients = SoilCoefficient.all
  end

  def edit
  end

  def update
    respond_to do |format|
      if @soil_coefficient.update_attributes(params[:soil_coefficient])
        format.html do
          clear_cache
          redirect_to admin_soil_coefficients_path, notice: 'Soil coefficient was successfully updated.'
        end
        format.json do
          clear_cache
          respond_with_bip(@soil_coefficient)
        end
      else
        format.html { render :edit }
        format.json { respond_with_bip(@soil_coefficient) }
      end
    end
  end

  private

  def load_soil_coefficient
    @soil_coefficient = SoilCoefficient.find(params[:id])
  end

  def load_soil_attributes
    @soil_moistures = SoilMoisture.all
    @soil_textures = SoilTexture.all
  end
end

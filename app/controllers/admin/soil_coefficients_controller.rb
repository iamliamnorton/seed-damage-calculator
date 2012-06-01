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
  # GET /soil_coefficients.json
  def index
    @soil_coefficients = SoilCoefficient.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @soil_coefficients }
    end
  end

  # GET /soil_coefficients/new
  # GET /soil_coefficients/new.json
  def new
    @soil_coefficient = SoilCoefficient.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @soil_coefficient }
    end
  end

  # GET /soil_coefficients/1/edit
  def edit
  end

  # POST /soil_coefficients
  # POST /soil_coefficients.json
  def create
    @soil_coefficient = SoilCoefficient.new(params[:soil_coefficient])

    respond_to do |format|
      if @soil_coefficient.save
        format.html { redirect_to admin_soil_coefficients_path, notice: 'Soil coefficient was successfully created.' }
        format.json { render json: @soil_coefficient, status: :created, location: @soil_coefficient }
      else
        format.html { render :new }
        format.json { render json: @soil_coefficient.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /soil_coefficients/1
  # PUT /soil_coefficients/1.json
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

  # DELETE /soil_coefficients/1
  # DELETE /soil_coefficients/1.json
  def destroy
    @soil_coefficient.destroy

    respond_to do |format|
      format.html { redirect_to admin_soil_coefficients_path, notice: 'Soil coefficient was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

end

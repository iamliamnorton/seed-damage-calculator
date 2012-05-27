class Admin::SoilMoisturesController < Admin::BaseController
  # GET /soil_moistures
  # GET /soil_moistures.json
  def index
    @soil_moistures = SoilMoisture.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @soil_moistures }
    end
  end

  # GET /soil_moistures/new
  # GET /soil_moistures/new.json
  def new
    @soil_moisture = SoilMoisture.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @soil_moisture }
    end
  end

  # GET /soil_moistures/1/edit
  def edit
    @soil_moisture = SoilMoisture.find(params[:id])
  end

  # POST /soil_moistures
  # POST /soil_moistures.json
  def create
    @soil_moisture = SoilMoisture.new(params[:soil_moisture])
    @soil_textures = SoilTexture.all

    respond_to do |format|
      if @soil_moisture.save
        @soil_textures.each do |soil_texture|
          SoilCoefficient.create(:soil_texture_id => soil_texture.id, :soil_moisture_id => @soil_moisture.id)
        end
        format.html { redirect_to admin_soil_moistures_path, notice: 'Soil moisture was successfully created.' }
        format.json { render json: @soil_moisture, status: :created, location: @soil_moisture }
      else
        format.html { render action: "new" }
        format.json { render json: @soil_moisture.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /soil_moistures/1
  # PUT /soil_moistures/1.json
  def update
    @soil_moisture = SoilMoisture.find(params[:id])

    respond_to do |format|
      if @soil_moisture.update_attributes(params[:soil_moisture])
        format.html { redirect_to admin_soil_moistures_path, notice: 'Soil moisture was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @soil_moisture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /soil_moistures/1
  # DELETE /soil_moistures/1.json
  def destroy
    @soil_moisture = SoilMoisture.find(params[:id])
    @soil_moisture.destroy

    respond_to do |format|
      format.html { redirect_to admin_soil_moistures_path, notice: 'Soil moisture was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

end

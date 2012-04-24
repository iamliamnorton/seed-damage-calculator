class Admin::SoilTexturesController < Admin::BaseController
  # GET /soil_textures
  # GET /soil_textures.json
  def index
    @soil_textures = SoilTexture.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @soil_textures }
    end
  end

  # GET /soil_textures/new
  # GET /soil_textures/new.json
  def new
    @soil_texture = SoilTexture.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @soil_texture }
    end
  end

  # GET /soil_textures/1/edit
  def edit
    @soil_texture = SoilTexture.find(params[:id])
  end

  # POST /soil_textures
  # POST /soil_textures.json
  def create
    @soil_texture = SoilTexture.new(params[:soil_texture])

    respond_to do |format|
      if @soil_texture.save
        format.html { redirect_to admin_soil_textures_path, notice: 'Soil texture was successfully created.' }
        format.json { render json: @soil_texture, status: :created, location: @soil_texture }
      else
        format.html { render action: "new" }
        format.json { render json: @soil_texture.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /soil_textures/1
  # PUT /soil_textures/1.json
  def update
    @soil_texture = SoilTexture.find(params[:id])

    respond_to do |format|
      if @soil_texture.update_attributes(params[:soil_texture])
        format.html { redirect_to admin_soil_textures_path, notice: 'Soil texture was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @soil_texture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /soil_textures/1
  # DELETE /soil_textures/1.json
  def destroy
    @soil_texture = SoilTexture.find(params[:id])
    @soil_texture.destroy

    respond_to do |format|
      format.html { redirect_to admin_soil_textures_path, notice: 'Soil texture was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
end

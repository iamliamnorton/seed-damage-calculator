class Admin::CropsController < Admin::BaseController

  before_filter :load_crop, :only => [:edit, :update, :destroy]

  def load_crop
     @crop = Crop.find(params[:id])
  end

  # GET /crops
  # GET /crops.json
  def index
    @crops = Crop.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @crops }
    end
  end

  # GET /crops/new
  # GET /crops/new.json
  def new
    @crop = Crop.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @crop }
    end
  end

  # GET /crops/1/edit
  def edit
  end

  # POST /crops
  # POST /crops.json
  def create
    @crop = Crop.new(params[:crop])
    @fertilisers = Fertiliser.all

    respond_to do |format|
      if @crop.save
        @fertilisers.each do |fertiliser|
          RegressionCoefficient.create(:crop_id => @crop.id, :fertiliser_id => fertiliser.id)
        end
        format.html { redirect_to admin_crops_path, notice: 'Crop was successfully created.' }
        format.json { render json: @crop, status: :created, location: @crop }
      else
        format.html { render :new }
        format.json { render json: @crop.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /crops/1
  # PUT /crops/1.json
  def update
    respond_to do |format|
      if @crop.update_attributes(params[:crop])
        format.html { redirect_to admin_crops_path, notice: 'Crop was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :edit }
        format.json { render json: @crop.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /crops/1
  # DELETE /crops/1.json
  def destroy
    @crop.destroy

    respond_to do |format|
      format.html { redirect_to admin_crops_path, notice: 'Crop was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

end

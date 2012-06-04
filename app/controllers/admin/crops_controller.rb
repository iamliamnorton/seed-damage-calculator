class Admin::CropsController < Admin::BaseController

  before_filter :load_crop, :only => [:edit, :update, :destroy]

  def load_crop
     @crop = Crop.find(params[:id])
  end

  # GET /crops
  def index
    @crops = Crop.all
  end

  # GET /crops/new
  def new
    @crop = Crop.new
  end

  # GET /crops/1/edit
  def edit
  end

  # POST /crops
  def create
    @crop = Crop.new(params[:crop])
    @fertilisers = Fertiliser.all

    if @crop.save
      @fertilisers.each do |fertiliser|
        RegressionCoefficient.create(:crop_id => @crop.id, :fertiliser_id => fertiliser.id)
      end
      flash[:notice] = 'Crop was successfully created.'
      redirect_to admin_crops_path,
    else
      render :new
    end
  end

  # PUT /crops/1
  def update
    if @crop.update_attributes(params[:crop])
      flash[:notice] = 'Crop was successfully updated.'
      redirect_to admin_crops_path
    else
      render :edit
    end
  end

  # DELETE /crops/1
  def destroy
    @crop.destroy
    flash[:notice] = 'Crop was successfully destroyed.'
    redirect_to admin_crops_path
  end
end

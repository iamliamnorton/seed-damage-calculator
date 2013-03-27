class Admin::CropsController < Admin::BaseController
  before_filter :load_crop, :only => [:edit, :update, :destroy]

  def index
    @crops = Crop.all
  end

  def new
    @crop = Crop.new
  end

  def edit
  end

  def create
    @crop = Crop.new(params[:crop])
    @fertilisers = Fertiliser.all

    if @crop.save
      @fertilisers.each do |fertiliser|
        RegressionCoefficient.create(:crop_id => @crop.id, :fertiliser_id => fertiliser.id)
      end
      clear_cache
      flash[:notice] = 'Crop was successfully created.'
      redirect_to admin_crops_path
    else
      render :new
    end
  end

  def update
    if @crop.update_attributes(params[:crop])
      clear_cache
      flash[:notice] = 'Crop was successfully updated.'
      redirect_to admin_crops_path
    else
      render :edit
    end
  end

  def destroy
    @crop.destroy
    clear_cache
    flash[:notice] = 'Crop was successfully destroyed.'
    redirect_to admin_crops_path
  end

  private

  def load_crop
    @crop = Crop.find(params[:id])
  end
end

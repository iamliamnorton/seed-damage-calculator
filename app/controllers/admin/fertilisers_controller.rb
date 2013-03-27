class Admin::FertilisersController < Admin::BaseController
  before_filter :load_fertiliser, :only => [:edit, :update, :destroy]

  def index
    @fertilisers = Fertiliser.all
  end

  def new
    @fertiliser = Fertiliser.new
  end

  def edit
  end

  def create
    @fertiliser = Fertiliser.new(params[:fertiliser])
    @crops = Crop.all

    if @fertiliser.save
      @crops.each do |crop|
        RegressionCoefficient.create(:crop_id => crop.id, :fertiliser_id => @fertiliser.id)
      end
      clear_cache
      flash[:notice] = 'Fertiliser was successfully created.'
      redirect_to admin_fertilisers_path
    else
      render :new
    end
  end

  def update
    if @fertiliser.update_attributes(params[:fertiliser])
      clear_cache
      flash[:notice] = 'Fertiliser was successfully updated.'
      redirect_to admin_fertilisers_path
    else
      render :edit
    end
  end

  def destroy
    clear_cache
    @fertiliser.destroy
    flash[:notice] = 'Fertiliser was successfully destroyed.'
    redirect_to admin_fertilisers_path
  end

  private

  def load_fertiliser
    @fertiliser = Fertiliser.find(params[:id])
  end
end

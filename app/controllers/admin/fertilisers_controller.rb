class Admin::FertilisersController < Admin::BaseController
  before_action :load_fertiliser, :only => [:edit, :update, :destroy]

  def index
    @fertilisers = Fertiliser.all
  end

  def new
    @fertiliser = Fertiliser.new
  end

  def edit
  end

  def create
    @fertiliser = Fertiliser.new(fertiliser_params)
    @crops = Crop.all

    if @fertiliser.save
      @crops.each do |crop|
        RegressionCoefficient.create(:crop_id => crop.id, :fertiliser_id => @fertiliser.id)
      end
      flash[:notice] = 'Fertiliser was successfully created.'
      redirect_to admin_fertilisers_path
    else
      render :new
    end
  end

  def update
    if @fertiliser.update_attributes(fertiliser_params)
      flash[:notice] = 'Fertiliser was successfully updated.'
      redirect_to admin_fertilisers_path
    else
      render :edit
    end
  end

  def destroy
    @fertiliser.destroy
    flash[:notice] = 'Fertiliser was successfully destroyed.'
    redirect_to admin_fertilisers_path
  end

  private

  def load_fertiliser
    @fertiliser = Fertiliser.find(params[:id])
  end

  def fertiliser_params
    params.require(:fertiliser).permit(:imperial_name, :metric_name, :N, :P, :K, :S, :Mg, :imperial_weight, :metric_weight)
  end
end

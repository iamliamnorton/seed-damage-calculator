class Admin::FertilisersController < Admin::BaseController

  before_filter :load_fertiliser, :only => [:edit, :update, :destroy]

  def load_fertiliser
     @fertiliser = Fertiliser.find(params[:id])
  end

  # GET /fertilisers
  def index
    @fertilisers = Fertiliser.all
  end

  # GET /fertilisers/new
  def new
    @fertiliser = Fertiliser.new
  end

  # GET /fertilisers/1/edit
  def edit
  end

  # POST /fertilisers
  def create
    @fertiliser = Fertiliser.new(params[:fertiliser])
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

  # PUT /fertilisers/1
  def update
    if @fertiliser.update_attributes(params[:fertiliser])
      flash[:notice] = 'Fertiliser was successfully updated.'
      redirect_to admin_fertilisers_path
    else
      render :edit
    end
  end

  # DELETE /fertilisers/1
  def destroy
    @fertiliser.destroy
    flash[:notice] = 'Fertiliser was successfully destroyed.'
    redirect_to admin_fertilisers_path
  end
end

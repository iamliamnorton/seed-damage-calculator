class Admin::RegressionCoefficientsController < Admin::BaseController

  before_filter :load_regression_coefficient, :only => [:edit, :update, :destroy]
  before_filter :load_other_attributes, :except => [:destroy]

  def load_regression_coefficient
     @regression_coefficient = RegressionCoefficient.find(params[:id])
  end

  def load_other_attributes
     @crops = Crop.order('name')
     @fertilisers = Fertiliser.all
  end

  # GET /regression_coefficients
  # GET /regression_coefficients.json
  def index
    @regression_coefficients = RegressionCoefficient.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @regression_coefficients }
    end
  end

  # GET /regression_coefficients/new
  # GET /regression_coefficients/new.json
  def new
    @regression_coefficient = RegressionCoefficient.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @regression_coefficient }
    end
  end

  # GET /regression_coefficients/1/edit
  def edit
  end

  # POST /regression_coefficients
  # POST /regression_coefficients.json
  def create
    @regression_coefficient = RegressionCoefficient.new(params[:regression_coefficient])

    respond_to do |format|
      if @regression_coefficient.save
        format.html { redirect_to admin_regression_coefficients_path, notice: 'Regression coefficient was successfully created.' }
        format.json { render json: @regression_coefficient, status: :created, location: @regression_coefficient }
      else
        format.html { render :new }
        format.json { render json: @regression_coefficient.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /regression_coefficients/1
  # PUT /regression_coefficients/1.json
  def update
    respond_to do |format|
      if @regression_coefficient.update_attributes(params[:regression_coefficient])
        format.html { redirect_to admin_regression_coefficients_path, notice: 'Regression coefficient was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :edit }
        format.json { render json: @regression_coefficient.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /regression_coefficients/1
  # DELETE /regression_coefficients/1.json
  def destroy
    @regression_coefficient.destroy

    respond_to do |format|
      format.html { redirect_to admin_regression_coefficients_path, notice: 'Regression coefficient was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

end

class Admin::RegressionCoefficientsController < ApplicationController
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
    @crops = Crop.all
    @fertilisers = Fertiliser.all

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @regression_coefficient }
    end
  end

  # GET /regression_coefficients/1/edit
  def edit
    @regression_coefficient = RegressionCoefficient.find(params[:id])
    @crops = Crop.all
    @fertilisers = Fertiliser.all
  end

  # POST /regression_coefficients
  # POST /regression_coefficients.json
  def create
    @regression_coefficient = RegressionCoefficient.new(params[:regression_coefficient])
    @crops = Crop.all
    @fertilisers = Fertiliser.all
    
    respond_to do |format|
      if @regression_coefficient.save
        format.html { redirect_to admin_regression_coefficients_path, notice: 'Regression coefficient was successfully created.' }
        format.json { render json: @regression_coefficient, status: :created, location: @regression_coefficient }
      else
        format.html { render action: "new" }
        format.json { render json: @regression_coefficient.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /regression_coefficients/1
  # PUT /regression_coefficients/1.json
  def update
    @regression_coefficient = RegressionCoefficient.find(params[:id])
    @crops = Crop.all
    @fertilisers = Fertiliser.all

    respond_to do |format|
      if @regression_coefficient.update_attributes(params[:regression_coefficient])
        format.html { redirect_to admin_regression_coefficients_path, notice: 'Regression coefficient was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @regression_coefficient.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /regression_coefficients/1
  # DELETE /regression_coefficients/1.json
  def destroy
    @regression_coefficient = RegressionCoefficient.find(params[:id])
    @regression_coefficient.destroy

    respond_to do |format|
      format.html { redirect_to admin_regression_coefficients_path, notice: 'Regression coefficient was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

end

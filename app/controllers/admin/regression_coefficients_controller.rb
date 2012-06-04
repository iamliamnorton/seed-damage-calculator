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
  def index
    @regression_coefficients = RegressionCoefficient.all
  end

  # GET /regression_coefficients/1/edit
  def edit
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
end

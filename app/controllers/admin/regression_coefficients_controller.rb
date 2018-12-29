class Admin::RegressionCoefficientsController < Admin::BaseController
  before_filter :load_regression_coefficient, :only => [:edit, :update, :destroy]
  before_filter :load_other_attributes, :except => [:destroy]

  def index
    @regression_coefficients = RegressionCoefficient.all
  end

  def edit
  end

  def update
    respond_to do |format|
      if @regression_coefficient.update_attributes(regression_coefficient_params)
        format.html { redirect_to admin_regression_coefficients_path, notice: 'Regression coefficient was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :edit }
        format.json { render json: @regression_coefficient.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def load_regression_coefficient
    @regression_coefficient = RegressionCoefficient.find(params[:id])
  end

  def load_other_attributes
    @crops = Crop.order('name')
    @fertilisers = Fertiliser.all
  end

  def regression_coefficient_params
    params.require(:regression_coefficient).permit(:value, :crop_id, :fertiliser_id)
  end
end

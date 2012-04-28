class Calculator
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  
  attr_accessor :crop_id, :fertiliser_id, :soil_moisture_id, :soil_texture_id, 
                :seed_furrow_opening_width, :row_spacing, :tolerated_stand_loss
  
  validates :seed_furrow_opening_width, :row_spacing, :tolerated_stand_loss, presence: true, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100 }
  
  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end
  
  def calculate_result
    regression_coefficient = RegressionCoefficient.where(:crop_id => self.crop_id, :fertiliser_id => self.fertiliser_id).first.value
    soil_coefficient = SoilCoefficient.where(:soil_moisture_id => self.soil_moisture_id, :soil_texture_id => self.soil_texture_id).first.value
    numerator = 30 * self.seed_furrow_opening_width.to_i * -1 * self.tolerated_stand_loss.to_i
    denominator = regression_coefficient * self.row_spacing.to_i * soil_coefficient
    result = numerator / denominator
    result = result * 1.1208511 if I18n.locale == :metric
    return result.round(2)
  end
end

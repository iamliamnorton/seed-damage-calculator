class Calculator
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  
  attr_accessor :crop_id, :fertiliser_id, :soil_moisture_id, :soil_texture_id, 
                :seed_furrow_opening_width, :row_spacing, :tolerated_stand_loss
  
  validates :seed_furrow_opening_width, :row_spacing, :tolerated_stand_loss, presence: true, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100 }
  validates :terms_of_service, :acceptance => true
  
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
    if self.valid?
      result = numerator / denominator
      result = result * 1.1208511 if I18n.locale == :metric
    end
    return result
  end
  
  def calculate_sbu
    if self.valid?
      sbu = (self.seed_furrow_opening_width.to_f / self.row_spacing.to_f) * 100
      sbu = sbu.round(0)
    end
    return sbu
  end
  
  def calculate_liquid_weight(result)
    fertiliser = Fertiliser.find_by_id(self.fertiliser_id)
    if fertiliser.liquid_weight.to_f > 0 && self.valid?
      liquid_weight = (result / fertiliser.liquid_weight).round(1)
    end
    return liquid_weight
  end
  
  def calculate_nitrogen(result)
    fertiliser = Fertiliser.find_by_id(self.fertiliser_id)
    if fertiliser.N.to_f > 0 && self.valid?
      nitrogen = (result * fertiliser.N).round(1)
    end
    return nitrogen
  end
  
  def calculate_phosphorus(result)
    fertiliser = Fertiliser.find_by_id(self.fertiliser_id)
    if fertiliser.P.to_f > 0 && self.valid?
      phosphorus = result * fertiliser.P
      phosphorus = phosphorus * 0.4364 if I18n.locale == :metric
      phosphorus = phosphorus.round(1)
    end
    return phosphorus
  end
  
  def calculate_potassium(result)
    fertiliser = Fertiliser.find_by_id(self.fertiliser_id)
    if fertiliser.K.to_f > 0 && self.valid?
      potassium = result * fertiliser.K
      potassium = potassium * 0.83 if I18n.locale == :metric
      potassium = potassium.round(1)
    end
    return potassium
  end
  
  def calculate_sulphur(result)
    fertiliser = Fertiliser.find_by_id(self.fertiliser_id)
    if fertiliser.S.to_f > 0 && self.valid?
      sulphur = (result * fertiliser.S).round(1)
    end
    return sulphur
  end
  
  def calculate_magnesium(result)
    fertiliser = Fertiliser.find_by_id(self.fertiliser_id)
    if fertiliser.Mg.to_f > 0 && self.valid?
      magnesium = (result * fertiliser.Mg).round(1)
    end
    return magnesium
  end
end

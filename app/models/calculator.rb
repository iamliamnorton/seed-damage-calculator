class Calculator
  include ActiveModel::Validations
  include ActiveModel::Conversion
  include ActiveModel::MassAssignmentSecurity
  extend ActiveModel::Naming

  attr_accessor :crop_id, :fertiliser_id, :soil_moisture_id, :soil_texture_id,
                :seed_furrow_opening_width, :row_spacing, :tolerated_stand_loss,
                :result, :sbu, :liquid_weight, :nitrogen, :phosphorus, :potassium,
                :sulphur, :magnesium

  attr_accessible :crop_id, :fertiliser_id, :soil_moisture_id, :soil_texture_id,
                  :seed_furrow_opening_width, :row_spacing, :tolerated_stand_loss

  validates :seed_furrow_opening_width, :row_spacing, :tolerated_stand_loss, presence: true, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100 }
  validates :terms_of_service, :acceptance => true

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
    if self.valid?
      calculate_result
      calculate_sbu
      calculate_liquid_weight
      calculate_nitrogen
      calculate_phosphorus
      calculate_potassium
      calculate_sulphur
      calculate_magnesium
      self.result = self.result.round(1)
    end
    self.persisted?
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
    self.result = result * 1.1208511 if I18n.locale == :metric
    self.result = result unless I18n.locale == :metric
  end

  def calculate_sbu
    sbu = (self.seed_furrow_opening_width.to_f / self.row_spacing.to_f) * 100
    self.sbu = sbu.round(0)
  end

  def calculate_liquid_weight
    fertiliser = Fertiliser.find_by_id(self.fertiliser_id)
    liquid_weight = (self.result / fertiliser.liquid_weight).round(1) if fertiliser.liquid_weight.to_f > 0
    self.liquid_weight = liquid_weight
  end

  def calculate_nitrogen
    fertiliser = Fertiliser.find_by_id(self.fertiliser_id)
    nitrogen = (self.result * fertiliser.N).round(1) if fertiliser.N.to_f > 0
    self.nitrogen = nitrogen
  end

  def calculate_phosphorus
    fertiliser = Fertiliser.find_by_id(self.fertiliser_id)
    if fertiliser.P.to_f > 0
      phosphorus = self.result * fertiliser.P
      phosphorus = phosphorus * 0.4364 if I18n.locale == :metric
      phosphorus = phosphorus.round(1)
      self.phosphorus = phosphorus
    end
  end

  def calculate_potassium
    fertiliser = Fertiliser.find_by_id(self.fertiliser_id)
    if fertiliser.K.to_f > 0
      potassium = self.result * fertiliser.K
      potassium = potassium * 0.83 if I18n.locale == :metric
      potassium = potassium.round(1)
      self.potassium = potassium
    end
  end

  def calculate_sulphur
    fertiliser = Fertiliser.find_by_id(self.fertiliser_id)
    sulphur = (self.result * fertiliser.S).round(1) if fertiliser.S.to_f > 0
    self.sulphur = sulphur
  end

  def calculate_magnesium
    fertiliser = Fertiliser.find_by_id(self.fertiliser_id)
    magnesium = (self.result * fertiliser.Mg).round(1) if fertiliser.Mg.to_f > 0
    self.magnesium = magnesium
  end
end

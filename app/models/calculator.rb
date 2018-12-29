class Calculator
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  METRIC_RESULT_MULIPLIER = 1.1208511
  METRIC_PHOSPHORUS_MULTIPLIER = 0.4364
  METRIC_POTASSIUM_MULTIPLIER = 0.83

  attr_accessor :locale
  attr_accessor :crop_id
  attr_accessor :fertiliser_id
  attr_accessor :soil_moisture_id
  attr_accessor :soil_texture_id
  attr_accessor :seed_furrow_opening_width
  attr_accessor :row_spacing
  attr_accessor :tolerated_stand_loss
  attr_accessor :result
  attr_accessor :sbu
  attr_accessor :liquid_weight
  attr_accessor :nitrogen
  attr_accessor :phosphorus
  attr_accessor :potassium
  attr_accessor :sulphur
  attr_accessor :magnesium

  validates :seed_furrow_opening_width,
    :row_spacing,
    :tolerated_stand_loss,
    presence: true,
    numericality: {
      greater_than_or_equal_to: 0,
      less_than_or_equal_to: 100
    }

  validates :terms_of_service, acceptance: true

  def initialize(attributes = {})
    attributes.to_h.each do |name, value|
      send("#{name}=", value)
    end

    if valid?
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
  end

  def persisted?
    false
  end

  def calculate_result
    self.result = (30 * seed_furrow_opening_width.to_i * -1 * tolerated_stand_loss.to_i)
    self.result = result / (regression_coefficient * row_spacing.to_i * soil_coefficient)
    self.result = result * METRIC_RESULT_MULIPLIER if metric?
  end

  def calculate_sbu
    sbu = (seed_furrow_opening_width.to_f / row_spacing.to_f) * 100
    self.sbu = sbu.round(0)
  end

  def calculate_liquid_weight
    calculation_weight = metric? ? fertiliser.metric_weight : fertiliser.imperial_weight

    if calculation_weight.to_f > 0
      self.liquid_weight = (self.result / calculation_weight).round(1)
    end
  end

  def calculate_nitrogen
    if fertiliser.N.to_f > 0
      self.nitrogen = (self.result * fertiliser.N).round(1)
    end
  end

  def calculate_phosphorus
    if fertiliser.P.to_f > 0
      phosphorus = self.result * fertiliser.P
      phosphorus = phosphorus * METRIC_PHOSPHORUS_MULTIPLIER if metric?
      self.phosphorus = phosphorus.round(1)
    end
  end

  def calculate_potassium
    if fertiliser.K.to_f > 0
      potassium = self.result * fertiliser.K
      potassium = potassium * METRIC_POTASSIUM_MULTIPLIER if metric?
      self.potassium = potassium.round(1)
    end
  end

  def calculate_sulphur
     if fertiliser.S.to_f > 0
       self.sulphur = (self.result * fertiliser.S).round(1)
     end
  end

  def calculate_magnesium
    if fertiliser.Mg.to_f > 0
      self.magnesium = (self.result * fertiliser.Mg).round(1)
    end
  end

  private

  def metric?
    self.locale.to_s == "metric"
  end

  def fertiliser
    @_fertiliser ||= Fertiliser
      .find(fertiliser_id)
  end

  def regression_coefficient
    @_regression_coefficient ||= RegressionCoefficient
      .where(crop_id: crop_id)
      .where(fertiliser_id: fertiliser_id)
      .first
      .value
  end

  def soil_coefficient
    @_soil_coefficient ||= SoilCoefficient
      .where(soil_moisture_id: soil_moisture_id)
      .where(soil_texture_id: soil_texture_id)
      .first
      .value
  end
end

class Calculator
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  
  attr_accessor :crop_id, :fertiliser_id, :soil_moisture_id, :soil_texture_id, :seed_furrow_opening_width, :row_spacing, :tolerated_stand_loss
  
  validates :seed_furrow_opening_width, :row_spacing, :tolerated_stand_loss, presence: true, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100 }
  
  def initialize(attributes = {})
      attributes.each do |name, value|
        send("#{name}=", value)
      end
    end

    def persisted?
      false
    end
end

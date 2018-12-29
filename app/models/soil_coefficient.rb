class SoilCoefficient < ApplicationRecord
  belongs_to :soil_texture
  belongs_to :soil_moisture
  delegate :name, :to => :soil_texture, :prefix => true
  delegate :name, :to => :soil_moisture, :prefix => true
  validates :value, :presence => true, :format => { :with => /\A\d+(?:\.\d{0,2})?\z/ }, :numericality => {:greater_than_or_equal_to => 0, :less_than => 10}
  validates_uniqueness_of :soil_moisture_id, :scope => 'soil_texture_id', :message => '/ texture coefficient already exists'
end

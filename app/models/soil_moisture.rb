class SoilMoisture < ApplicationRecord
  has_many :soil_coefficients, :dependent => :destroy
  validates :name, :presence => true, :uniqueness => true
end

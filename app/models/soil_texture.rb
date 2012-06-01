class SoilTexture < ActiveRecord::Base
  has_many :soil_coefficients, :dependent => :destroy
  validates :name, :presence => true, :uniqueness => true
  attr_accessible :name
end

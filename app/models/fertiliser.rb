class Fertiliser < ActiveRecord::Base
  has_many :regression_coefficients, :dependent => :destroy
  validates :metric_name, :imperial_name, :presence => true
  validates_uniqueness_of :metric_name, :imperial_name, :case_sensitive => false
  validates :N, :P, :K, :S, :Mg, :format => { :with => /^\d+??(?:\.\d{0,2})?$/ }, :numericality => {:greater_than_or_equal_to => 0, :less_than_or_equal_to => 1}
  validates :liquid_weight, :format => { :with => /^\d+??(?:\.\d{0,6})?$/ }, :numericality => {:greater_than_or_equal_to => 0, :less_than => 10}
end

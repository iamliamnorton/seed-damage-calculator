class Fertiliser < ApplicationRecord
  has_many :regression_coefficients, :dependent => :destroy
  validates :metric_name, :imperial_name, :presence => true
  validates_uniqueness_of :metric_name, :imperial_name, :case_sensitive => false
  validates :N, :P, :K, :S, :Mg, :format => { :with => /\A\d+(?:\.\d{0,2})?\z/ }, :numericality => {:greater_than_or_equal_to => 0, :less_than_or_equal_to => 1}
  validates :metric_weight, :format => { :with => /\A\d+(?:\.\d{0,6})?\z/ }, :numericality => {:greater_than_or_equal_to => 0, :less_than => 10}
  validates :imperial_weight, :format => { :with => /\A\d+(?:\.\d{0,2})?\z/ }, :numericality => {:greater_than_or_equal_to => 0, :less_than => 20}
end

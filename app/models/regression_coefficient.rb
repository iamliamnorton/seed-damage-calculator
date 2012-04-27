class RegressionCoefficient < ActiveRecord::Base
  belongs_to :crop
  belongs_to :fertiliser
  
  validates :value, :presence => true, :numericality => {:greater_than => -10, :less_than => 10}
  validates_uniqueness_of :crop_id, :scope => 'fertiliser_id', :message => '/ Fertiliser coefficient already exists'
end
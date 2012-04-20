class Fertiliser < ActiveRecord::Base
  validates :name, :presence => true
  validates_uniqueness_of :name, :case_sensitive => false
  validates :N, :P, :K, :S, :Mg, :format => { :with => /^\d+??(?:\.\d{0,2})?$/ }, :numericality => {:greater_than_or_equal_to => 0, :less_than => 10}
  validates :kgL, :format => { :with => /^\d+??(?:\.\d{0,6})?$/ }, :numericality => {:greater_than_or_equal_to => 0, :less_than => 10}
end

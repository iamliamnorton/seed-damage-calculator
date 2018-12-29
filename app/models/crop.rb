class Crop < ApplicationRecord
  has_many :regression_coefficients, dependent: :destroy
  validates :name, presence: true
  validates_uniqueness_of :name, case_sensitive: false
end

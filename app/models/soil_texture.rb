class SoilTexture < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true
end

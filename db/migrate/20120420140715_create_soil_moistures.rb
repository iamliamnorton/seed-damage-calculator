class CreateSoilMoistures < ActiveRecord::Migration
  def change
    create_table :soil_moistures do |t|
      t.string :name

      t.timestamps
    end
  end
end

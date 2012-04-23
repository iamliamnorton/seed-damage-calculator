class CreateSoilCoefficients < ActiveRecord::Migration
  def change
    create_table :soil_coefficients do |t|
      t.decimal :value,             :precision => 3, :scale => 2, :null => false, :default => 0
      t.references :soil_texture
      t.references :soil_moisture

      t.timestamps
    end
    add_index :soil_coefficients, :soil_texture_id
    add_index :soil_coefficients, :soil_moisture_id
  end
end

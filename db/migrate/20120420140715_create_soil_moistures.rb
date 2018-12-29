class CreateSoilMoistures < ActiveRecord::Migration[4.2]
  def change
    create_table :soil_moistures do |t|
      t.string :name

      t.timestamps
    end
  end
end

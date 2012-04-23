class CreateRegressionCoefficients < ActiveRecord::Migration
  def change
    create_table :regression_coefficients do |t|
      t.decimal :value,         :precision => 4, :scale => 3, :null => false, :default => 0
      t.references :crop
      t.references :fertiliser

      t.timestamps
    end
    add_index :regression_coefficients, :crop_id
    add_index :regression_coefficients, :fertiliser_id
  end
end

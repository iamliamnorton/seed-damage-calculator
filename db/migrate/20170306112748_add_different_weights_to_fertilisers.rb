class AddDifferentWeightsToFertilisers < ActiveRecord::Migration[4.2]
  def up
    rename_column :fertilisers, :liquid_weight, :metric_weight
    add_column :fertilisers, :imperial_weight, :decimal, precision: 4, scale: 2, null: false, default: 0
  end

  def down
    rename_column :fertilisers, :metric_weight, :liquid_weight
    remove_column :fertilisers, :imperial_weight
  end
end

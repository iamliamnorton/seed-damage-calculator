class CreateFertilisers < ActiveRecord::Migration
  def change
    create_table :fertilisers do |t|
      t.string :metric_name
      t.string :imperial_name
      t.decimal :N,               :precision => 3, :scale => 2, :null => false, :default => 0
      t.decimal :P,               :precision => 3, :scale => 2, :null => false, :default => 0
      t.decimal :K,               :precision => 3, :scale => 2, :null => false, :default => 0
      t.decimal :S,               :precision => 3, :scale => 2, :null => false, :default => 0
      t.decimal :Mg,              :precision => 3, :scale => 2, :null => false, :default => 0
      t.decimal :liquid_weight,   :precision => 7, :scale => 6, :null => false, :default => 0

      t.timestamps
    end
  end
end

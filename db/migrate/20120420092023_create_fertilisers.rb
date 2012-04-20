class CreateFertilisers < ActiveRecord::Migration
  def change
    create_table :fertilisers do |t|
      t.string :name
      t.decimal :N,     :precision => 3, :scale => 2, :null => false, :default => 0
      t.decimal :P,     :precision => 3, :scale => 2, :null => false, :default => 0
      t.decimal :K,     :precision => 3, :scale => 2, :null => false, :default => 0
      t.decimal :S,     :precision => 3, :scale => 2, :null => false, :default => 0
      t.decimal :Mg,    :precision => 3, :scale => 2, :null => false, :default => 0
      t.decimal :kgL,   :precision => 7, :scale => 6, :null => false, :default => 0

      t.timestamps
    end
  end
end

class CreateCrops < ActiveRecord::Migration
  def change
    create_table :crops do |t|
      t.string :name,   :null => false

      t.timestamps
    end
  end
end

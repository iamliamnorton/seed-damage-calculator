class CreateSoilTextures < ActiveRecord::Migration
  def change
    create_table :soil_textures do |t|
      t.string :name

      t.timestamps
    end
  end
end

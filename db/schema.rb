# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120423022943) do

  create_table "crops", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "fertilisers", :force => true do |t|
    t.string   "metric_name"
    t.string   "imperial_name"
    t.decimal  "N",             :precision => 3, :scale => 2, :default => 0.0, :null => false
    t.decimal  "P",             :precision => 3, :scale => 2, :default => 0.0, :null => false
    t.decimal  "K",             :precision => 3, :scale => 2, :default => 0.0, :null => false
    t.decimal  "S",             :precision => 3, :scale => 2, :default => 0.0, :null => false
    t.decimal  "Mg",            :precision => 3, :scale => 2, :default => 0.0, :null => false
    t.decimal  "liquid_weight", :precision => 7, :scale => 6, :default => 0.0, :null => false
    t.datetime "created_at",                                                   :null => false
    t.datetime "updated_at",                                                   :null => false
  end

  create_table "regression_coefficients", :force => true do |t|
    t.decimal  "value",         :precision => 4, :scale => 3, :default => 0.0, :null => false
    t.integer  "crop_id"
    t.integer  "fertiliser_id"
    t.datetime "created_at",                                                   :null => false
    t.datetime "updated_at",                                                   :null => false
  end

  add_index "regression_coefficients", ["crop_id"], :name => "index_regression_coefficients_on_crop_id"
  add_index "regression_coefficients", ["fertiliser_id"], :name => "index_regression_coefficients_on_fertiliser_id"

  create_table "soil_coefficients", :force => true do |t|
    t.decimal  "value",            :precision => 3, :scale => 2, :default => 0.0, :null => false
    t.integer  "soil_texture_id"
    t.integer  "soil_moisture_id"
    t.datetime "created_at",                                                      :null => false
    t.datetime "updated_at",                                                      :null => false
  end

  add_index "soil_coefficients", ["soil_moisture_id"], :name => "index_soil_coefficients_on_soil_moisture_id"
  add_index "soil_coefficients", ["soil_texture_id"], :name => "index_soil_coefficients_on_soil_texture_id"

  create_table "soil_moistures", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "soil_textures", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end

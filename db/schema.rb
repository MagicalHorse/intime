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

ActiveRecord::Schema.define(:version => 20130320075419) do

  create_table "brands", :force => true do |t|
    t.string   "name"
    t.string   "desc"
    t.string   "englishname"
    t.string   "logo"
    t.string   "website"
    t.integer  "status"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "cards", :force => true do |t|
    t.string   "no"
    t.string   "level"
    t.integer  "point"
    t.datetime "validatedate"
    t.string   "utoken"
    t.boolean  "isbinded"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.string   "desc"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "products", :force => true do |t|
    t.string   "name"
    t.string   "desc"
    t.decimal  "price",           :precision => 10, :scale => 0
    t.string   "recommendreason"
    t.integer  "status"
    t.integer  "store_id"
    t.integer  "tag_id"
    t.integer  "sortorder"
    t.integer  "user_id"
    t.datetime "created_at",                                     :null => false
    t.datetime "updated_at",                                     :null => false
  end

  add_index "products", ["store_id"], :name => "index_products_on_store_id"
  add_index "products", ["tag_id"], :name => "index_products_on_tag_id"
  add_index "products", ["user_id"], :name => "index_products_on_user_id"

  create_table "promotions", :force => true do |t|
    t.string   "name"
    t.string   "desc"
    t.integer  "status"
    t.integer  "store_id"
    t.datetime "begindate"
    t.datetime "enddate"
    t.integer  "limitcoupons"
    t.integer  "tag_id"
    t.boolean  "istop"
    t.boolean  "hasprod"
    t.integer  "user_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "promotions", ["store_id"], :name => "index_promotions_on_store_id"
  add_index "promotions", ["tag_id"], :name => "index_promotions_on_tag_id"

  create_table "promotions_products", :force => true do |t|
    t.integer  "promotion_id"
    t.integer  "product_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "regions", :force => true do |t|
    t.string   "name"
    t.string   "desc"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "stores", :force => true do |t|
    t.string   "name"
    t.string   "desc"
    t.string   "address"
    t.string   "telephone"
    t.decimal  "lngit",      :precision => 10, :scale => 0
    t.decimal  "latit",      :precision => 10, :scale => 0
    t.integer  "status"
    t.decimal  "gpslngit",   :precision => 10, :scale => 0
    t.decimal  "gpslatit",   :precision => 10, :scale => 0
    t.decimal  "gpsalt",     :precision => 10, :scale => 0
    t.integer  "company_id"
    t.integer  "region_id"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  add_index "stores", ["company_id"], :name => "index_stores_on_company_id"
  add_index "stores", ["region_id"], :name => "index_stores_on_region_id"

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.string   "desc"
    t.integer  "sortorder"
    t.integer  "status"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "user_requests", :force => true do |t|
    t.string   "utoken"
    t.string   "msg"
    t.string   "lastaction"
    t.integer  "lastpage"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "nickie"
    t.string   "pwd"
    t.string   "mobile"
    t.string   "email"
    t.integer  "status"
    t.integer  "level"
    t.string   "logo"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end

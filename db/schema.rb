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

ActiveRecord::Schema.define(:version => 20140708043529) do

  create_table "auth_keys", :force => true do |t|
    t.string   "private"
    t.string   "publickey"
    t.integer  "status"
    t.string   "desc"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "banners", :force => true do |t|
    t.integer  "status"
    t.integer  "sortorder"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

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

  add_index "cards", ["no", "utoken"], :name => "index_cards_on_no_and_utoken"
  add_index "cards", ["utoken", "isbinded"], :name => "index_cards_on_utoken_and_isbinded"

  create_table "combo_pics", :force => true do |t|
    t.integer  "remote_id"
    t.integer  "combo_id"
    t.string   "url"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "combo_products", :force => true do |t|
    t.integer  "remote_id"
    t.integer  "combo_id"
    t.string   "img_url"
    t.string   "product_type"
    t.decimal  "price",         :precision => 10, :scale => 1
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
    t.string   "brand_name"
    t.string   "category_name"
  end

  create_table "combos", :force => true do |t|
    t.integer  "remote_id"
    t.string   "private_to"
    t.string   "combo_type"
    t.text     "desc"
    t.decimal  "price",        :precision => 10, :scale => 1
    t.datetime "created_at",                                                     :null => false
    t.datetime "updated_at",                                                     :null => false
    t.boolean  "has_discount",                                :default => false
    t.decimal  "discount",     :precision => 10, :scale => 1
    t.boolean  "is_public"
  end

  create_table "comments", :force => true do |t|
    t.integer  "status"
    t.string   "textmsg"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "user_id"
    t.integer  "source_id"
    t.string   "source_type"
    t.integer  "reply_id"
  end

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.string   "desc"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "coupon_rebate_logs", :force => true do |t|
    t.string   "code"
    t.integer  "coupontype"
    t.string   "storeno"
    t.string   "receiptno"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "hotwords", :force => true do |t|
    t.integer  "status"
    t.integer  "type"
    t.integer  "sortorder"
    t.string   "word"
    t.integer  "brandid"
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
    t.integer  "updateduser_id"
  end

  add_index "products", ["store_id"], :name => "index_products_on_store_id"
  add_index "products", ["tag_id"], :name => "index_products_on_tag_id"
  add_index "products", ["user_id"], :name => "index_products_on_user_id"

  create_table "products_promotions", :force => true do |t|
    t.integer  "promotion_id"
    t.integer  "product_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

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

  create_table "regions", :force => true do |t|
    t.string   "name"
    t.string   "desc"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "resources", :force => true do |t|
    t.string   "domain"
    t.string   "name"
    t.integer  "sortorder"
    t.integer  "status"
    t.integer  "width"
    t.integer  "height"
    t.integer  "length"
    t.integer  "type"
    t.integer  "source_id"
    t.string   "source_type"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "simulation_orders", :force => true do |t|
    t.integer  "paymentcode"
    t.string   "paymentname"
    t.string   "invoicetitle"
    t.string   "invoicedetail"
    t.string   "companyname"
    t.text     "memo"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "simulation_products", :force => true do |t|
    t.integer  "order_id"
    t.integer  "productid"
    t.integer  "quantity"
    t.integer  "sizevalueid"
    t.string   "sizevaluename"
    t.integer  "colorvalueid"
    t.string   "colorvaluename"
    t.text     "desc"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "special_topics", :force => true do |t|
    t.string   "name"
    t.string   "desc"
    t.integer  "status"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "store_coupon_logs", :force => true do |t|
    t.integer  "coupontype"
    t.string   "code"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "storeno"
    t.string   "receiptno"
    t.integer  "status"
  end

  add_index "store_coupon_logs", ["created_at"], :name => "index_store_coupon_logs_on_created_at"

  create_table "store_coupons", :force => true do |t|
    t.integer  "status"
    t.string   "code"
    t.decimal  "amount",         :precision => 10, :scale => 2
    t.integer  "userid"
    t.datetime "validstartdate"
    t.datetime "validenddate"
    t.string   "vipcard"
    t.integer  "coupontype"
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
    t.boolean  "islimitonce"
  end

  add_index "store_coupons", ["code", "coupontype"], :name => "index_store_coupons_on_code_and_coupontype"

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

  add_index "user_requests", ["utoken"], :name => "index_user_requests_on_utoken"

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

  create_table "versions", :force => true do |t|
    t.integer  "no"
    t.string   "versionno"
    t.integer  "status"
    t.string   "desc"
    t.string   "downloadurl"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "updatetype"
  end

  create_table "wx_activity_logs", :force => true do |t|
    t.integer  "activity_id"
    t.string   "uid"
    t.string   "vip_card"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "wx_activity_logs", ["uid", "activity_id"], :name => "index_wx_activity_logs_on_uid_and_activity_id"

  create_table "wx_custom_activities", :force => true do |t|
    t.string   "key"
    t.integer  "status"
    t.datetime "valid_from"
    t.datetime "valid_end"
    t.string   "succsss_msg"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "join_msg"
    t.string   "how_msg"
  end

  add_index "wx_custom_activities", ["key", "status"], :name => "index_wx_custom_activities_on_key_and_status"

  create_table "wx_reply_msgs", :force => true do |t|
    t.string   "rkey"
    t.string   "rmsg"
    t.integer  "status"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "wx_reply_msgs", ["rkey"], :name => "index_wx_reply_msgs_on_rkey"

end

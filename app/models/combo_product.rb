# encoding: utf-8
class ComboProduct < ActiveRecord::Base
  attr_accessible :remote_id, :combo_id, :img_url, :product_type, :price, :brand_name, :category_name, :unitprice

  belongs_to :combo

  after_create :recount_combo_price
  before_destroy :recount_combo_price
  validate :verify_product_count, on: :create

  def recount_combo_price
  	combo.update_attribute(:price, combo.combo_products.sum(&:price))
  end

  def verify_product_count
    errors.add(:base, "一个搭配最多添加3个商品") if ComboProduct.where(combo_id: combo_id).count >= 3
  end
end
